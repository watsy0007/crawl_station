module CrawlStation
  module ScheduleAdapters
    class AbstractAdapter
      def push(_item)
      end
      def pop
      end
      def empty?
      end

      def failed(item)
      end

      def done(item)
      end
    end
  end
end
