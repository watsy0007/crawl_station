$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'crawl_station'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
