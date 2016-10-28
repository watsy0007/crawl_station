module CrawlStation
  module Adapters
    module CacheAdapters
      class MemoryAdapter < AbstractAdapter
        def initialize
          @cache = {}
          @cache.extend(MonitorMixin)
          ['[]=', '[]', 'include?'].each do |method_name|
            define_singleton_method method_name do |*args|
              @cache.synchronize do
                @cache.send(method_name, *args)
              end
            end
          end
        end
      end
    end
  end
end
