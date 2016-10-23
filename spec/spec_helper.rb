$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV['CRAWL_STATION_ENV'] = 'test'
require 'crawl_station'
require 'simplecov'
require 'codeclimate-test-reporter'
require 'byebug' if CrawlStation.env.test?
SimpleCov.start
