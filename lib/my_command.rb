require "my_command/version"
require "launchy"
require 'httparty'

module MyCommand
  class CatApi
    include HTTParty

    def initialize(command = 'browser')
      @command = command
    end

    def run
      if @command == 'browser'
        response = HTTParty.get('http://thecatapi.com/api/images/get?format=xml&type=jpg,png')
        image_url = response['response']['data']['images']['image']['url']
        Launchy.open(image_url)
      end
    end
  end
end
