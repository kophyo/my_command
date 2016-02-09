require 'spec_helper'

describe MyCommand::CatApi do
  describe '.get_random_image_url' do
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

    it 'returns an image url' do
      allow(HTTParty).to receive(:get).with('http://thecatapi.com/api/images/get?format=xml&type=jpg,png').and_return(response)
      expect(MyCommand::CatApi.get_random_image_url).to eq('some_url')
    end
  end

  describe '.get_binary_image' do
    let(:response) do
      double(parsed_response: 'cat image')
    end

    it 'returns an image url' do
      allow(HTTParty).to receive(:get).with('http://thecatapi.com/api/images/get?type=jpg').and_return(response)
      expect(MyCommand::CatApi.get_binary_image).to eq('cat image')
    end
  end

  describe '.get_facts' do
    let(:response) do
      double(parsed_response: raw_response)
    end

    context 'with no parameter' do
      let(:raw_response) do
        "{\"facts\": [\"cat_1\"], \"success\": \"true\"}"
      end

      it 'returns an image url' do
        allow(HTTParty).to receive(:get).with('http://catfacts-api.appspot.com/api/facts?number=1').and_return(response)
        expect(MyCommand::CatApi.get_facts).to eq(['cat_1'])
      end
    end

    context 'with parameter' do
      let(:raw_response) do
        "{\"facts\": [\"cat_1\", \"cat_2\"], \"success\": \"true\"}"
      end

      it 'returns an image url' do
        allow(HTTParty).to receive(:get).with('http://catfacts-api.appspot.com/api/facts?number=2').and_return(response)
        expect(MyCommand::CatApi.get_facts(2)).to eq(['cat_1', 'cat_2'])
      end
    end
  end
end
