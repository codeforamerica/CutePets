require 'cute_pets/post_generator'
require 'minitest/autorun'

describe 'FacebookPostGenerator' do
  describe '.create_message' do
    it 'returns a string with the pet name, description and shelter link' do
      message = PostGenerator.create_message('Moofle', 'neutered female lab', 'http://www.example.org/moofle')
      message.must_match /Moofle. I am a neutered female lab. http\:\/\/www\.example\.org\/moofle/
    end

    it 'returns a string with the appropriate article' do
      message = PostGenerator.create_message('Miffle', 'unaltered female kitten', 'http://www.example.org/miffle')
      message.must_match /Miffle. I am an unaltered female kitten. http\:\/\/www\.example\.org\/miffle/
    end
  end

  describe '.post' do
    it 'uses the koala gem to post to facebook' do
      client_object = MiniTest::Mock.new
      PostGenerator.stub :facebook_client, client_object do
        message = 'Hi! I am Woofles. I am a neutered female nerdy cat. http://www.example.org/woofles'
        pet_pic = 'spec/fixtures/cat.jpg'
        client_object.expect(:put_connections, nil, [String, String, Hash])
        PostGenerator.post_facebook(message, pet_pic)
      end
    end
  end
end
