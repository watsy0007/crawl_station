module CrawlStation
  class Launcher
    include Celluloid
    include Celluloid::Notifications

    def initialize
      @exit_sign = false
      subscribe 'exit_launcher', :exit_message
    end

    def start
      CS.logger.debug('station starting ... ')

      CS.concurrent_count.times do
        supervisor = CS::Producer.pool args: [CS.schedule, CS.cache]
        supervisor.async.start
      end
      loop do
        sleep(10)
        break if @exit_sign
      end
    end

    def exit_message(_topic, data)
      @exit_sign = data
    end
  end
end
