require 'yaml'
require 'active_support/core_ext'
module CrawlStation
  module Utils
    class << self
      def module_path(module_name)
        "#{CS.root}/module/#{module_name}"
      end

      def database_path(module_name = nil)
        global_db_path = "#{CS.root}/config/database.yml"
        return global_db_path if module_name.nil?
        path = "#{module_path(module_name)}/config/database.yml"
        return path if File.exist?(path)
        global_db_path
      end

      def database_config(module_name = nil)
        result = ERB.new(IO.read(database_path(module_name))).result
        ::YAML.load(result).deep_symbolize_keys[CS.env.to_sym]
      end

      def create_database(module_name)
        config = database_config(module_name)
        ActiveRecord::Base.logger = CS.logger
        begin
          ActiveRecord::Base.establish_connection config
          ActiveRecord::Base.connection
        rescue
          ActiveRecord::Base.establish_connection config.merge(database: nil)
          ActiveRecord::Base.connection.create_database config[:database]
        else
          CS.logger.debug "database: #{config[:database]} already exist"
        end
      end

      def templates_path
        "#{gem_path}/crawl_station/templates"
      end

      def template_filepath(path)
        "#{templates_path}/#{path}"
      end

      def gem_path
        File.expand_path('../../crawl_station/', __FILE__)
      end
    end
  end
end
