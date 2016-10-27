require 'active_support/concern'
module CrawlStation
  module Concerns
    module ParserClassConcern
      extend ActiveSupport::Concern

      included do
        def parser_class
          path = "#{namespace}/parser/#{parser}"
          path.camelize.constantize
        end

        def item_class
          path = "#{namespace}/item/#{parser}"
          path.camelize.constantize
        end
      end
    end
  end
end
