module CrawlStation
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.table_name_prefix
      "#{module_name}_"
    end

    def self.database_config
      CS::Utils.database_config(module_name)
    end

    def self.module_name
      name.to_s.split('::').first.underscore
    end
  end
end
