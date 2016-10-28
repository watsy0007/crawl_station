module CrawlStation
  module Configuration
    extend self
    attr_accessor :adapter
    attr_accessor :parsers
    attr_accessor :proxies
    attr_accessor :cache_frequency
  end
end
