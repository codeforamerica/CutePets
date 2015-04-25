require './lib/cute_pets/pet_fetcher'
require './lib/cute_pets/tweet_generator'
require './lib/cute_pets/status_generator'
require 'dotenv'
Dotenv.load

module CutePets
  extend self

  def post_pet_twitter()
    pet = nil
    if ENV.fetch('pet_datasource').downcase == 'petfinder'
      pet = PetFetcher.get_petfinder_pet
    else
      pet = PetFetcher.get_petharbor_pet
    end
    if pet
      message = TweetGenerator.create_message(pet[:name], pet[:description], pet[:link])
      TweetGenerator.tweet(message, pet[:pic])
    end
  end

  def post_pet_facebook()
    pet = nil
    if ENV.fetch('pet_datasource').downcase == 'petfinder'
      pet = PetFetcher.get_petfinder_pet
    else
      pet = PetFetcher.get_petharbor_pet
    end
    if pet
      message = StatusGenerator.create_message(pet[:name], pet[:description], pet[:link])
      StatusGenerator.post(message, pet[:pic])
    end
  end
end