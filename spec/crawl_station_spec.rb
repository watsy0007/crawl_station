require 'spec_helper'

describe CrawlStation do
  it 'has a version number' do
    expect(CrawlStation::VERSION).not_to be nil
  end

  it 'station env' do
    expect(CrawlStation.env.development?).to be true
    CrawlStation.env = 'production'
    expect(CrawlStation.env.production?).to be true
    CrawlStation.env = 'development'
  end

  it 'has logger ' do
    expect(CrawlStation.logger.class.to_s).to eq 'Logger'
  end
end
