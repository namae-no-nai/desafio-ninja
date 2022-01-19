class Schedule < ApplicationRecord
  belongs_to :room
  validates :begin_time, :end_time, presence:true
  validate :schedule_time_validation

  private

  def schedule_time_validation
    if schedule_time_already_taken? || !available_schedule_time_window?
      errors.add(:schedule_time, 'is unavailable')
    end
  end

  def schedule_time_already_taken?
    Schedule.where('? >= begin_time AND ? < end_time AND room_id = ?', begin_time, begin_time, room_id).present? ||
      Schedule.where('? > begin_time AND ? <= end_time AND room_id = ?', end_time, end_time, room_id).present?
  end

  def available_schedule_time_window?
    return false unless begin_time.on_weekday? && end_time.on_weekday?

    begin_time >= begin_time.beginning_of_day + 12.hours &&
      end_time <= end_time.beginning_of_day + 21.hours
  end
end
