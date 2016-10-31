require 'spec_helper'

RSpec.describe CS::Adapters::ProxyAdapters::MemoryAdapter do
  let(:obj) { CS::Adapters::ProxyAdapters::MemoryAdapter.new }

  it 'dynamic defined method should exist' do
    %w(push pop empty?).each { |m| expect(obj.respond_to?(m)).to be true }
  end

  it 'dynamic define method should be work' do
    obj.push(1)
    expect(obj.pop)
  end
end
