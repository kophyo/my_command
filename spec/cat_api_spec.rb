require 'spec_helper'

describe MyCommand::CatApi do
  describe '#run' do
    subject { MyCommand::CatApi.new(command)}
    context 'browse command' do
      let(:command) { 'browser' }
      let(:response) do
        {
          'response' => {
            'data' => {
              'images' => {
                'image' => {
                  'url' => 'some_url'
                }
              }
            }
          }
        }
      end

      it 'open a new browser window showing a cat image' do
        allow(HTTParty).to receive(:get).with('http://thecatapi.com/api/images/get?format=xml&type=jpg,png').and_return(response)

        expect(Launchy).to receive(:open).with("some_url")
        subject.run
      end

      it 'sets browse as default command if no command is passed in' do
        expect(MyCommand::CatApi.new.command).to eq('browser')
      end
    end

    context 'file command' do
      let(:command) { 'file' }
      let(:response) do
        double(parsed_response: 'Hello World')
      end

      let(:cat_image_file) { File.join('/tmp', 'test.txt') }

      it 'save on the desktop an image of a cat, as an image file' do
        allow(subject).to receive(:cat_image_file).and_return(cat_image_file)
        allow(HTTParty).to receive(:get).with('http://thecatapi.com/api/images/get?type=jpg').and_return(response)
        subject.run
        expect(File.read(cat_image_file)).to eq('Hello World')
      end
    end

    context 'fact command' do
      let(:command) { 'fact' }
      let(:response) do
        double(parsed_response: raw_response)
      end

      let(:raw_response) do
        "{\"facts\": [\"Cats are cute.\"], \"success\": \"true\"}"
      end

      it 'print to stdout a cat fact' do
        allow(HTTParty).to receive(:get).with('http://catfacts-api.appspot.com/api/facts').and_return(response)

        expect(STDOUT).to receive(:puts).with('Cats are cute.')
        subject.run
      end
    end

    context 'save_facts command' do
      let(:command) { 'save_facts' }
      let(:response) do
        double(parsed_response: raw_response)
      end

      let(:raw_response) do
        "{\"facts\": [\"Cats are cute.\", \"Cats are awesome.\"], \"success\": \"true\"}"
      end

      let(:cat_facts_file) { File.join('/tmp', 'test_facts.txt') }

      it 'saves 100 facts into txt file on Desktop' do
        allow(subject).to receive(:cat_facts_file).and_return(cat_facts_file)
        allow(HTTParty).to receive(:get).with('http://catfacts-api.appspot.com/api/facts?number=100').and_return(response)

        subject.run
        expect(File.read(cat_facts_file)).to eq("1. Cats are cute.\n2. Cats are awesome.")
      end
    end
  end
end
