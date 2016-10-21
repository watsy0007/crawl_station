require 'crawl_station/version'
require 'pathname'
require 'active_support'
require 'active_support/dependencies/autoload'
require 'logger'
module CrawlStation # :nodoc:
  extend ActiveSupport::Autoload

  autoload :Logger
  autoload :Utils

  class << self
    def env
      @_env ||= ActiveSupport::StringInquirer.new(ENV['CRAWL_STATION_ENV'] || 'development')
    end

    def env=(environment)
      @_env = ActiveSupport::StringInquirer.new(environment)
    end

    def root
      Pathname.new(File.expand_path('.'))
    end

    def logger
      @_logger ||= begin
                     CrawlStation::Logger.logger ||= ::Logger.new(STDERR) do |log|
                       log.level = ::Logger.DEBUG
                     end
                   end
    end

    def logger=(logger)
      @_logger = CrawlStation::Logger.logger = logger
    end
  end
end

CS = CrawlStation
