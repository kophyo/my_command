require 'spec_helper'

describe MyCommand::CatCommand do
  describe '#run' do
    subject { MyCommand::CatCommand.new(command)}
    context 'browse command' do
      let(:command) { 'browser' }

      it 'open a new browser window showing a cat image' do
        allow(MyCommand::CatApi).to receive(:get_random_image_url).and_return('some_url')
        expect(Launchy).to receive(:open).with("some_url")
        subject.run
      end

      it 'sets browse as default command if no command is passed in' do
        expect(MyCommand::CatCommand.new.command).to eq('browser')
      end
    end

    context 'file command' do
      let(:command) { 'file' }
      let(:cat_image_file) { File.join('/tmp', 'test.txt') }

      it 'save on the desktop an image of a cat, as an image file' do
        allow(MyCommand::CatApi).to receive(:get_binary_image).and_return('Hello World')
        allow(subject).to receive(:cat_image_file).and_return(cat_image_file)
        subject.run
        expect(File.read(cat_image_file)).to eq('Hello World')
      end
    end

    context 'fact command' do
      let(:command) { 'fact' }
      let(:facts) do
        ["Cats are cute."]
      end

      it 'print to stdout a cat fact' do
        allow(MyCommand::CatApi).to receive(:get_facts).and_return(facts)
        expect(STDOUT).to receive(:puts).with('Cats are cute.')
        subject.run
      end
    end

    context 'save_facts command' do
      let(:command) { 'save_facts' }
      let(:facts) do
        ["Cats are cute.", "Cats are awesome."]
      end
      let(:cat_facts_file) { File.join('/tmp', 'test_facts.txt') }

      it 'saves 100 facts into txt file on Desktop' do
        allow(MyCommand::CatApi).to receive(:get_facts).with(100).and_return(facts)
        allow(subject).to receive(:cat_facts_file).and_return(cat_facts_file)
        subject.run
        expect(File.read(cat_facts_file)).to eq("1. Cats are cute.\n2. Cats are awesome.")
      end
    end
  end
end
