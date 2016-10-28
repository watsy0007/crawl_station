module CrawlStation
  module Adapters
    module ScheduleAdapters
      class DbAdapter < AbstractAdapter
        def push(item)
          item = ParseStruct.new(item) if item.is_a?(Hash)
          schedule.new(
            parser: item.parser,
            namespace: item.namespace,
            link: item.link
          ).save
        end
        def pop
          schedule.transaction do
            model = schedule.waitings.first
            model.progressing!
            model
          end
        end
        def empty?
          schedule.waitings.size.zero?
        end

        def failed(item)
          return if item.nil?
          schedule.transaction do
            model = schedule.find_by(id: item.id)
            model.failed! if item.present?
          end
        end

        def done(item)
          return if item.nil?
          schedule.transaction do
            model = schedule.find_by(id: item.id)
            model.done! if item.present?
          end
        end

        private

        def schedule
          @_schedule ||= CS::Model::Schedule
        end
      end
    end
  end
end
