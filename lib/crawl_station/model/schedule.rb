module CrawlStation
  module Model
    class Schedule < ApplicationRecord
      include Concerns::ParserClassConcern
      establish_connection database_config

      enum status: [:waiting, :progressing, :done, :failed]

      default_scope -> { order(id: :desc) }

      scope :waitings, -> { where(status: :waiting) }
      scope :progressings, -> { where(status: :progressing) }
      scope :progressed, -> { where(status: [:done]) }
      scope :recent_1_day, -> { where('created_at > ?', 1.day.ago) }
    end
  end
end
