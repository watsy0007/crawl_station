require 'spec_helper'

describe CrawlStation do
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
end
