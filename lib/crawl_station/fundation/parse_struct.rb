require 'ostruct'
module CrawlStation
  class ParseStruct
    extend Forwardable
    include ParserClassConcern
    attr_accessor :parse

    %w(namespace parser item link).each do |method_name|
      define_method(method_name) { get_value(method_name) }
      define_method("#{method_name}=") { |v| set_value(method_name, v) }
    end

    def initialize(opts = {})
      @parse = opts
      @parse.deep_symbolize_keys!
    end

    def [](item)
      get_value(item)
    end

    def []=(item, value)
      set_value(item, value)
    end

    private

    def get_value(item)
      @parse[item.to_sym]
    end

    def set_value(item, value)
      @parse[item.to_sym] = value
    end
  end
end
