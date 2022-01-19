class Room < ApplicationRecord
  has_many :schedules
  validates :name, presence:true, uniqueness:true

  def as_json
    attributes.merge(
      {
        schedules: schedules
      }
    ).to_json
  end
end
