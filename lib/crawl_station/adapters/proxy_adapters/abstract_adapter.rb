module CrawlStation
  module Adapters
    module ProxyAdapters
      class AbstractAdapter
        def push(_item)
        end

        def pop
        end

        def empty?
        end

        def closed(_item)
        end
      end
    end
  end
end
