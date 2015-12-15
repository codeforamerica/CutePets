require './lib/cute_pets/pet_fetcher'
require './lib/cute_pets/post_generator'
require 'dotenv'
Dotenv.load

module CutePets
  extend self

  def post_pet(environment)
    pet = nil
    if ENV.fetch('pet_datasource').downcase == 'petfinder'
      pet = PetFetcher.get_petfinder_pet
    else
      pet = PetFetcher.get_petharbor_pet
    end
    if pet
      message = PostGenerator.create_message(pet[:name], pet[:description], pet[:link])
      case environment
        when :twitter
          PostGenerator.post_twitter(message, pet[:pic])
        when :facebook
          PostGenerator.post_facebook(message, pet[:pic])
        else
          raise "Argument must be Facebook of Twitter"
      end
    end
  end
end