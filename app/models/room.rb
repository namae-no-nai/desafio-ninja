# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :schedules
  validates :name, presence: true, uniqueness: true

  def as_hash
    attributes.merge(
      {
        schedules: schedules.map(&:as_hash)
      }
    )
  end
end
