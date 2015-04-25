require 'cute_pets'
require 'minitest/autorun'

# Couldn't find a way to effectively mock modules via minitest :(
describe 'CutePets' do
  describe '.post_pet' do
    before do
      @pet_hash = { name:        'schooples',
                   link:         'http://www.example.com/schooples',
                   pic:          'http://www.example.com/schooples.jpg',
                   description:  'neutured female fluffy dog'
                 }
    end
    it 'fetches pet finder data when the env var datasource is set to petfinder' do
      ENV.stub :fetch, 'petfinder' do
        PetFetcher.stub(:get_petfinder_pet, @pet_hash) do
          TweetGenerator.stub(:tweet, nil, [String, String]) do
            CutePets.post_pet_twitter
          end
        end
      end
    end

    it 'fetches pet harbor data when the env var datasource is set to petharbor' do
      ENV.stub :fetch, 'petharbor' do
        PetFetcher.stub(:get_petharbor_pet, @pet_hash) do
          TweetGenerator.stub(:tweet, nil, [String, String]) do
            CutePets.post_pet_twitter
          end
        end
      end
    end
  end
end
