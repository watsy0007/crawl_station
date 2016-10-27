module CrawlStation
  module Model
    class Cache < ApplicationRecord
      establish_connection database_config
    end
  end
end
