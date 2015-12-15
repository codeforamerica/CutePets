require 'koala'
require 'open-uri'
# This is terrible, but required. It resets a const in open-uri to guarantee that a File object
# is always returned when open() is called. Without it, data less than 10k will cause open() to
# return a StringIO object, which twitter can't handle.
OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0

require 'yaml'
require 'dotenv'
Dotenv.load

module PostGenerator
  extend self

  MESSAGES = YAML.load(File.open('lib/greetings.yml'))

  def post_facebook(message, pet_pic_url)
    options = {
        :message => message,
        :picture => pet_pic_url
    }
    facebook_client.put_connections("me", "feed", options)
  end

  def post_twitter(message, pet_pic_url)
    pet_pic_img = open(pet_pic_url)
    twitter_client.update_with_media(message, pet_pic_img)
  end

  def create_message(pet_name, pet_description, pet_link)
    full_description = %w(a e i o u).include?(pet_description[0]) ? "an #{pet_description}" : "a #{pet_description}"
    "#{greeting} #{pet_name}. I am #{full_description}. #{pet_link}"
  end

  def greeting
    MESSAGES.sample
  end

  def facebook_client
    begin
      Koala::Facebook::API.new(ENV.fetch('oauth_access_token'))
    rescue
      raise "Please check that your facebook keys are correct"
    end
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      begin
        config.consumer_key = ENV.fetch('api_key')
        config.consumer_secret = ENV.fetch('api_secret')
        config.access_token = ENV.fetch('access_token')
        config.access_token_secret = ENV.fetch('access_token_secret')
      rescue KeyError
        raise "Please check that your twitter keys are correct"
      end
    end
  end
end