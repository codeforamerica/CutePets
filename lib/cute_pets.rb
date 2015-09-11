require './lib/cute_pets/pet_fetcher'
require './lib/cute_pets/tweet_generator'
require 'dotenv'
Dotenv.load

module CutePets
  extend self

  def fetch_pet
    if ENV.fetch("pet_datasource").downcase == "petfinder"
      PetFetcher.get_petfinder_pet
    else
      PetFetcher.get_petharbor_pet
    end
  end

  def get_history
    history_filepath = File.expand_path(ENV.fetch("history_file"))
    history = File.file?(history_filepath) ? File.readlines(history_filepath) : []
  end
  
  def append_history(text)
    history_filepath = File.expand_path(ENV.fetch("history_file"))
    File.open(history_filepath, "a") do |f|
      f.puts text
    end
  end

  def post_pet
    pet = nil
    pet = fetch_pet
    num_tries = ENV.fetch("number_tries").to_i
    history = get_history
    # Try a few times to find one we haven't tweeted before.
    num_tries.times do
      break unless history.include?(pet[:link] + "\n")
      pet = fetch_pet
    end

    if pet
      append_history(pet[:link])
      message = TweetGenerator.create_message(pet[:name], pet[:description], pet[:link])
      TweetGenerator.tweet(message, pet[:pic])
    end
  end
end
