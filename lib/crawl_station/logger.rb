module CrawlStation
  module Logger
    class << self
      attr_accessor :logger
      def method_missing(method_name, *args, &block)
        return false if logger.nil?
        return super unless logger.respond_to?(method_name)
        logger.send(method_name, *args, &block)
      end
    end
  end
end
