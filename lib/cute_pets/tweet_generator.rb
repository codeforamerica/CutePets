require 'twitter'
require 'yaml'

MESSAGES = YAML.load(File.open("lib/greetings.yml"))

Module TweetGenerator
  extends self

  def tweet(message, pet_pic)
    client.update_with_media(message, pet_pic)
  end

  def create_message(pet_name, pet_description, pet_link)
    "#{greeting} #{pet_name} #{pet_description} #{pet_link}"
    # pet.desc.slice(0..65)
  end

private

  def greeting
    MESSAGES.sample
  end

  def client
    Twitter::REST::Client.new do |config|
      begin
        config.consumer_key = ENV.fetch('consumer_key')
        config.consumer_secret = ENV.fetch('consumer_secret')
        config.access_token = ENV.fetch('access_token')
        config.access_token_secret = ENV.fetch('access_token_secret')

      rescue KeyError
        raise "Please check that your twitter keys are correct"
      end
    end
  end
end