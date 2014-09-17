require './lib/cute_pets/pet_fetcher'
require './lib/cute_pets/tweet_generator'
require 'dotenv'
Dotenv.load

module CutePets
  extend self

  def post_pet()
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
end