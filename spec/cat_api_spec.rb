require 'spec_helper'

describe MyCommand::CatApi do
  describe '#run' do
    subject { MyCommand::CatApi.new(command)}
    context 'browse command' do
      let(:command) { 'browse' }
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
    end
  end
end
