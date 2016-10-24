require 'crawl_station/version'
require 'pathname'
require 'active_support'
require 'active_record'
require 'active_support/dependencies/autoload'
require 'logger'
require 'celluloid/debug'
require 'celluloid/current'
module CrawlStation # :nodoc:
  extend ActiveSupport::Autoload

  autoload :Logger
  autoload :Utils
  autoload :ApplicationRecord
  autoload :Producer
  autoload :Launcher
  autoload :Cache
  autoload :Schedule
  autoload :ParseStruct, 'crawl_station/fundation/parse_struct'

  module ScheduleAdapters
    extend ActiveSupport::Autoload

    autoload :AbstractAdapter
    autoload :MemoryAdapter
    autoload :DbAdapter
  end

  module CacheAdapters
    extend ActiveSupport::Autoload

    autoload :AbstractAdapter
    autoload :MemoryAdapter
    autoload :DbAdapter
  end

  module Concerns
    extend ActiveSupport::Autoload

    autoload :AdapterConcern
  end

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

    def parser_module_path
      'parser'
    end

    def concurrent_count
      @_concurrent_count ||= ENV['CRAWL_STATION_CONCURRENT_COUNT'] || 1
    end

    def concurrent_count=(count)
      @_concurrent_count = count
    end

    def schedule
      Schedule.adapter
    end

    def schedule=(item)
      Schedule.adpater(item)
    end

    def cache
    end

    def cache=(item)
    end

    def proxies
    end

    def proxies(item)
    end
  end
end

CS = CrawlStation
Celluloid.boot
