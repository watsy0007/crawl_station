require 'active_support/concern'
module CrawlStation
  module Concerns
    module CrawlStationClass
      extend ActiveSupport::Concern

      class_methods do
        def config
          yield @config if block_given?
        end

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
          Cache.adapter
        end

        def cache=(item)
          Cache.adapter(item)
        end

        def proxies
        end

        def proxies(item)
        end

        def load_tasks
          task_path = File.expand_path('../../', __FILE__)
          puts task_path
          [
            "#{task_path}/tasks/*.rake",
            "#{CrawlStation.root}/lib/tasks/**/*.rake"
          ].each { |path| Dir[path].each { |f| load f } }
        end

        def load_modules
          %w(item parser config).each do |path|
            Dir["#{CS.root}/module/*/#{path}/**/*.rb"].each { |f| require f }
          end
        end

        def init_application
          @config ||= CrawlStation::Configuration
          Dir["#{CS.root}/config/initializers/**/*.rb"].each { |f| require f }
        end

        def config_adapter
          adapter = @config.adapter || 'memory'
          schedule = adapter
          cache = adapter
        end

        def config_parsers
          parsers = @config.parsers || []
          parsers.each { |p| schedule.push p }
        end

        def boot
          init_application
          load_modules
          config_adapter
          config_parsers
        end
      end
    end
  end
end
