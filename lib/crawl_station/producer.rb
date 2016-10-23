require 'celluloid'
module CrawlStation
  class Producer
    include Celluloid

    attr_accessor :schedule, :cache, :proxies, :proxy

    def initalize(schedule, cache, proxies)
      @schdule = schedule
      @cache = cache
      @proxies = proxies
    end

    def start
      loop do

      end
    end
  end
end
