$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV['CRAWL_STATION_ENV'] = 'test'
require 'crawl_station'
require 'celluloid/test'
require 'simplecov'
require 'codeclimate-test-reporter'
require 'byebug' if CrawlStation.env.test?
RSpec.configure do |config|
  config.mock_with :rspec do |mocks|

    mocks.verify_doubled_constant_names = true
  end
end

SimpleCov.start
