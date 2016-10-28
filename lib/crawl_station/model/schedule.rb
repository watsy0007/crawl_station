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
      scope :recents, ->(frequency) { where('created_at > ?', frequency.ago) }
      scope :recent_1_day, -> { recents(1.day) }

    end
  end
end
