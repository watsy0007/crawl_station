module CrawlStation
  module Proxy
    extend self
    extend Forwardable
    include Concerns::AdapterConcern

    def adapter=(adapter_name)
      custom_adapter(adapter_name, CrawlStation::Adapters::ProxyAdapters)
    end
  end
end
