module CrawlStation
  class Producer
    include Celluloid

    attr_accessor :schedule, :cache, :proxies, :proxy

    def initialize(schedule, cache, proxies = nil)
      @schdule = schedule
      @cache = cache
      @proxies = proxies
    end

    def start
      loop do
        puts 'start ........'
        puts self.class
      end
    end
  end
end
