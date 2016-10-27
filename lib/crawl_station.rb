require 'crawl_station/version'
require 'pathname'
require 'active_support'
require 'active_record'
require 'active_support/dependencies/autoload'
require 'logger'
require 'thor'
require 'celluloid/debug'
require 'celluloid/current'
module CrawlStation # :nodoc:
  extend ActiveSupport::Autoload

  autoload :Configuration
  autoload :Logger
  autoload :Utils
  autoload :ApplicationRecord
  autoload :Producer
  autoload :Launcher
  autoload :Cache
  autoload :Schedule
  autoload :ParseStruct, 'crawl_station/fundation/parse_struct'
  autoload :Command

  module ScheduleAdapters
    extend ActiveSupport::Autoload

    autoload :AbstractAdapter
    autoload :MemoryAdapter
    autoload :DbAdapter
  end

  module Command
    extend ActiveSupport::Autoload

    autoload :Create
    autoload :Generate
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
    autoload :ParserClassConcern
    autoload :CrawlStationClass
  end

  module Model
    extend ActiveSupport::Autoload

    autoload :Cache
    autoload :Schedule
  end
end

CS = CrawlStation
CS.send(:include, CS::Concerns::CrawlStationClass)

Celluloid.boot
