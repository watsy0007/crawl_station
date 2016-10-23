module CrawlStation
  module Schedule
    extend self
    extend Forwardable

    def adapter
      return @adapter if @adapter
      self.adapter = :memory
      @adapter
    end

    def adapter=(adapter_name)
      case adapter_name
      when String, Symbol
        adapter_full_name = "#{adapter_name}_adapter"
        @adapter = CrawlStation::ScheduleAdapters.const_get(adapter_full_name.camelize).new
      end
    rescue NameError => e
        CS.logger.error "Schedule missing adapter #{adapter_name}"
    end

    def_delegators :@adapter, :push, :pop, :empty?, :include?
  end
end
