require "my_command/version"
require "launchy"
require 'httparty'

module MyCommand
  class CatApi
    include HTTParty
    attr_reader :command

    def initialize(command = nil)
      @command = command || 'browser'
    end

    def run
      case command
      when 'browser'
        response = HTTParty.get('http://thecatapi.com/api/images/get?format=xml&type=jpg,png')
        image_url = response['response']['data']['images']['image']['url']
        Launchy.open(image_url)
      when 'file'
        File.open(cat_image_file, "wb") do |f|
          f.binmode
          f.write HTTParty.get('http://thecatapi.com/api/images/get?type=jpg').parsed_response
        end
      when 'fact'
        response = JSON.parse(HTTParty.get('http://catfacts-api.appspot.com/api/facts').parsed_response)
        puts response['facts'].first
      when 'save_facts'
        response = JSON.parse(HTTParty.get('http://catfacts-api.appspot.com/api/facts?number=100').parsed_response)
        File.open(cat_facts_file, "wb") do |f|
          f.write response['facts'].each_with_index.map{|fact, i| "#{i+1}. #{fact}"}.join("\n")
        end
      else
        puts "Invalid argument. Please use either browser, file, fact or save_facts"
      end
    end

    def cat_image_file
      File.join(Dir.home, 'Desktop', 'cat_image.jpg')
    end

    def cat_facts_file
      File.join(Dir.home, 'Desktop', 'cat_facts.txt')
    end
  end
end
