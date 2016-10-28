module CrawlStation
  module Schedule
    extend self
    extend Forwardable
    include Concerns::AdapterConcern

    def adapter=(adapter_name)
      custom_adapter(adapter_name, CrawlStation::Adapters::ScheduleAdapters)
    end

    def_delegators :@adapter, :push, :pop, :empty?, :include?
  end
end
