module CrawlStation
  module ScheduleAdapters
    class MemoryAdapter < AbstractAdapter
      def initialize
        @queue = Queue.new
        @queue.extend(MonitorMixin)
        %w(push pop empty?).each do |method_name|
          self.define_singleton_method method_name do |*args|
            @queue.synchronize do
              @queue.send(method_name, *args)
            end
          end
        end
      end
    end
  end
end
