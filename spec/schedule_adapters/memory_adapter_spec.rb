require 'spec_helper'

RSpec.describe CrawlStation::ScheduleAdapters::MemoryAdapter do
  let(:obj) { CrawlStation::ScheduleAdapters::MemoryAdapter.new }
  it 'dynamic define method should exist' do
    %w(push pop empty?).each { |m| expect(obj.respond_to?(m)).to be true }
  end

  it 'dynamic defined method should work' do
    obj.push(1)
    expect(obj.pop).to eq 1
  end
end
