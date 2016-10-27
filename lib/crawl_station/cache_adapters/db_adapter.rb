module CrawlStation
  module CacheAdapters
    class DbAdapter < AbstractAdapter
      def [](key)
        recent_schedule.where(link: key).first
      end

      def include?(key)
        recent_schedule.exists?(link: key)
      end

      private
      def recent_schedule
        schedule.progressed.recent_1_day
      end
      def schedule
        @_schedule ||= CS::Model::Schedule
      end
    end
  end
end
