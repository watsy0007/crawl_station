require 'celluloid'
module CrawlStation
  class Launcer
    include Celluloid

    def start
      CS.logger.debug('station starting ... ')

      CS.concurrent_count.times do
        supervisor = CS::Producer.pool args: [ CS.schdule, CS.cache, CS.proxies ]
        supervisor.async.start
      end
      loop { sleep(1_000) }
    end
  end
end
