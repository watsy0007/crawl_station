module CrawlStation
  module ScheduleAdapters
    class DbAdapter < AbstractAdapter
      def push(_item)
      end
      def pop
      end
      def empty?
      end

      def failed(_item)
      end

      def done(_item)
      end
    end
  end
end
