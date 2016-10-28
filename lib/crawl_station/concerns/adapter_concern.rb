require 'active_support/concern'
module CrawlStation
  module Concerns
    module AdapterConcern
      extend ActiveSupport::Concern

      class_methods do
        def adapter
          return @_adapter if @_adapter
          self.adapter = :memory
          @_adapter
        end

        def custom_adapter(adapter_name, adapter_module)
          case adapter_name
          when String, Symbol
            adapter_full_name = "#{adapter_name}_adapter"
            @_adapter = adapter_module.const_get(adapter_full_name.camelize).new
          end
        # rescue NameError => e
          # CS.logger.error "Cache missing adapter #{adapter_name}"
        end
      end
    end
  end
end
