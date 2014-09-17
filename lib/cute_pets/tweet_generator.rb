require 'twitter'
require 'yaml'
require 'open-uri'
require 'dotenv'
Dotenv.load

module TweetGenerator
  extend self

  MESSAGES = YAML.load(File.open('lib/greetings.yml'))

  def tweet(message, pet_pic_url)
    pet_pic_img = open(pet_pic_url)
    if pet_pic_img.is_a?(StringIO)
      ext = File.extname(pet_pic_url)
      name = File.basename(pet_pic_url, ext)
      pet_pic_img = Tempfile.new([name, ext])
    end
    client.update_with_media(message, pet_pic_img)
  end

  def create_message(pet_name, pet_description, pet_link)
    full_description = %w(a e i o u).include?(pet_description[0]) ? "an #{pet_description}" : "a #{pet_description}"
    "#{greeting} #{pet_name}. I am #{full_description}. #{pet_link}"
  end

  def greeting
    MESSAGES.sample
  end

  def client
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