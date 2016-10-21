require 'spec_helper'

describe CrawlStation::Logger do
  let(:logger) { CrawlStation.logger }
  it 'proxy logger method' do
    %w(debug info warn error).each do |method|
      expect(logger.respond_to?(method)).to be true
    end
    expect(logger.respond_to?('error_method')).to be false
  end
end
