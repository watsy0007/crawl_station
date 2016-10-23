module CrawlStation
  module Cache
    extend self
    extend Forwardable
    include Concerns::AdapterConcern

    def adapter=(adapter_name)
      custom_adapter(adapter_name, CrawlStation::CacheAdapters)
    end

    def_delegators :@adapter, :[]=, :[], :include?
  end
end
