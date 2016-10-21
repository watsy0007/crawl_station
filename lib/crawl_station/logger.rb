module CrawlStation
  module Logger
    class << self
      attr_accessor :logger
      def method_missing(method_name, *args, &block)
        return logger.send(method_name, *args, &block) if !logger.nil? && logger.respond_to?(method_name)
        super
      end

      def respond_to?(method_name)
        (logger && logger.respond_to?(method_name)) || super
      end
    end
  end
end
