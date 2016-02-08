require 'spec_helper'

describe MyCommand do
  it 'has a version number' do
    expect(MyCommand::VERSION).not_to be nil
  end
end
