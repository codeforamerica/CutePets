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

  def post_pet
    pet = nil
    pet = fetch_pet
    # Check that we haven't tweeted this pet before.
    history_file = ENV.fetch("history_file")
    history_filepath = File.expand_path(history_file)
    if File.file?(history_filepath)
      num_tries = ENV.fetch("number_tries").to_i
      history = File.readlines(history_filepath)
      num_tries.times do
        new_pet = true
        history.each do |url|
          if url.strip == pet[:link]
            new_pet = false
            break
          end
        end
        break if new_pet
        pet = fetch_pet
      end
    end

    if pet
      File.open(history_filepath, "a") do |f|
        f.puts pet[:link]
      end
      message = TweetGenerator.create_message(pet[:name], pet[:description], pet[:link])
      TweetGenerator.tweet(message, pet[:pic])
    end
  end
end
