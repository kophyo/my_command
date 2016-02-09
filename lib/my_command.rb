require "my_command/version"
require "launchy"
require 'httparty'

module MyCommand
  class CatApi
    include HTTParty
    attr_reader :command

    def initialize(command = 'browser')
      @command = command
    end

    def run
      if @command == 'browser'
        response = HTTParty.get('http://thecatapi.com/api/images/get?format=xml&type=jpg,png')
        image_url = response['response']['data']['images']['image']['url']
        Launchy.open(image_url)
      elsif @command == 'file'
        File.open(desktop_image_file, "wb") do |f|
          f.binmode
          f.write HTTParty.get('http://thecatapi.com/api/images/get?type=jpg').parsed_response
        end
      end
    end

    def desktop_image_file
      File.join(Dir.home, 'Desktop', 'cat_image.jpg')
    end
  end
end
