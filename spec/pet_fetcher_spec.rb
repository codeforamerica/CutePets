require 'cute_pets/pet_fetcher'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

describe 'PetFetcher' do
  VCR.configure do |c|
    c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
    c.hook_into :webmock
  end

  describe '.get_petfinder_pet' do
    it 'returns a hash of pet data when the API request is successful' do
      VCR.use_cassette('petfinder') do
        pet_hash = PetFetcher.get_petfinder_pet
        pet_hash[:breed].must_equal 'Ferret'
        pet_hash[:pic].must_equal 'http://photos.petfinder.com/photos/pets/30078059/1/?bust=1409196072&width=500&-x.jpg'
        pet_hash[:link].must_equal 'https://www.petfinder.com/petdetail/30078059'
        pet_hash[:name].must_equal 'JOEY'
        pet_hash[:id].must_equal '30078059'
        pet_hash[:sex].must_equal 'Male'
        pet_hash[:type].must_equal 'Small & Furry'
      end
    end
 
    it 'raises when the API request fails' do
      stub_request(:get, /^http\:\/\/api\.petfinder\.com\/pet\.getRandom/).to_return(:status => 500)
      lambda { PetFetcher.get_petfinder_pet }.must_raise RuntimeError
    end
  end

  describe '.get_petharbor_pet' do
    it 'returns a hash of pet data when the request is successful' do
      VCR.use_cassette('petharbor') do
          pet_hash = PetFetcher.get_petharbor_pet
          pet_hash[:breed].must_equal 'WHITE BICHON FRISE'
          pet_hash[:pic].must_equal 'http://www.PetHarbor.com/get_image.asp?RES=Thumb&ID=A223117&LOCATION=DNVR'
          pet_hash[:link].must_equal 'http://www.PetHarbor.com/detail.asp?ID=A223117&LOCATION=DNVR&searchtype=rnd&shelterlist=\'DNVR\'&where=dummy&kiosk=1'
          pet_hash[:name].must_equal 'MORTY'
          pet_hash[:id].must_equal 'A223117'
          pet_hash[:sex].must_equal 'Male'
          pet_hash[:type].must_equal 'Dog'
      end
    end
  end

  it 'raises when the request fails' do
    stub_request(:get, /^http\:\/\/www\.petharbor\.com\/petoftheday\.asp/).to_return(:status => 500)
    lambda { PetFetcher.get_petharbor_pet }.must_raise RuntimeError
  end
end
