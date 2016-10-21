module CrawlStation
  module Logger
    class << self
      attr_accessor :logger
      def method_missing(method_name, *args, &block)
        logger.send(method_name, *args, &block) || super
      end

      def respond_to_missing?(method_name)
        return false if logger.nil?
        logger.respond_to?(method_name) || super
      end
    end
  end
end
