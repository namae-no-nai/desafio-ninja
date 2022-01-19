class Schedule < ApplicationRecord
  belongs_to :room
  validates :begin_time, :end_time, presence:true
  validate :schedule_time_validation

  private

  def schedule_time_validation
    if Schedule.where('? >= begin_time AND ? < end_time AND room_id = ?', begin_time, begin_time, room_id).present? ||
       Schedule.where('? > begin_time AND ? <= end_time AND room_id = ?', end_time, end_time, room_id).present?
      errors.add(:schedule_time, 'has been already taken')
    end
  end
end
