require 'httparty'

module MyCommand
  class CatApi
    include HTTParty
    class << self
      def get_random_image_url
        response = HTTParty.get('http://thecatapi.com/api/images/get?format=xml&type=jpg,png')
        response['response']['data']['images']['image']['url']
      end

      def get_binary_image
        HTTParty.get('http://thecatapi.com/api/images/get?type=jpg').parsed_response
      end

      def get_facts(number=1)
        JSON.parse(HTTParty.get("http://catfacts-api.appspot.com/api/facts?number=#{number}").parsed_response)['facts']
      end
    end
  end
end