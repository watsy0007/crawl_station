require 'spec_helper'

RSpec.describe CS::Adapters::CacheAdapters::MemoryAdapter do
  let(:obj) { CS::Adapters::CacheAdapters::MemoryAdapter.new }
  it 'dynamic define method should exist' do
    %w([]= [] include?).each { |m| expect(obj.respond_to?(m)).to be true }
  end

  it 'dynamic defined method should work' do
    key = 'key'
    value = 'value'
    expect(obj.include?(key)).to be false
    obj[key] = value
    expect(obj.include?(key)).to be true
    expect(obj[key]).to eq value
  end
end
