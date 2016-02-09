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

      let(:desktop_image_file) { File.join('/tmp', 'test.txt') }

      it 'save on the desktop an image of a cat, as an image file' do
        allow(subject).to receive(:desktop_image_file).and_return(desktop_image_file)
        allow(HTTParty).to receive(:get).with('http://thecatapi.com/api/images/get?type=jpg').and_return(response)
        subject.run
        expect(File.read(desktop_image_file)).to eq('Hello World')
      end
    end
  end
end
