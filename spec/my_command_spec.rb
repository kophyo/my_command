require 'spec_helper'

describe MyCommand do
  it 'has a version number' do
    expect(MyCommand::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
