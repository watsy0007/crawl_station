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

      def templates_path
        "#{gem_path}/templates"
      end

      def template_filepath(path)
        "#{templates_path}/#{path}"
      end

      def gem_path
        File.expand_path('../../', __FILE__)
      end
    end
  end
end
