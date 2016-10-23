require 'spec_helper'

RSpec.describe CrawlStation do
  it 'has a version number' do
    expect(CrawlStation::VERSION).not_to be nil
  end

  it 'station env' do
    expect(CrawlStation.env.test?).to be true
    CrawlStation.env = 'production'
    expect(CrawlStation.env.production?).to be true
    CrawlStation.env = 'test'
  end

  it 'has logger ' do
    CrawlStation.logger = nil
    expect(CrawlStation.logger.class.to_s).to eq 'Logger'
  end

  it 'has a concurrent count' do
    default_count = CrawlStation.concurrent_count
    expect(CrawlStation.concurrent_count).to eq 1
    CrawlStation.concurrent_count = 5
    expect(CrawlStation.concurrent_count).to eq 5
    CS.concurrent_count = default_count
  end
end
