require "my_command/version"
require "my_command/cat_api"
require "launchy"

module MyCommand
  class CatCommand
    attr_reader :command

    def initialize(command = nil)
      @command = command || 'browser'
    end

    def run
      case command
      when 'browser'
        open_image_in_browser
      when 'file'
        save_image_file
      when 'fact'
        print_out_cat_fact
      when 'save_facts'
        save_facts_file
      else
        puts "Invalid argument. Please use either browser, file, fact or save_facts"
      end
    end

    private

    def open_image_in_browser
      Launchy.open(CatApi.get_random_image_url)
    end

    def save_image_file
      File.open(cat_image_file, "wb") do |f|
        f.binmode
        f.write CatApi.get_binary_image
      end
    end

    def print_out_cat_fact
      puts CatApi.get_facts.first
    end

    def save_facts_file
      File.open(cat_facts_file, "wb") do |f|
        f.write CatApi.get_facts(100).each_with_index.map{|fact, i| "#{i+1}. #{fact}"}.join("\n")
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
