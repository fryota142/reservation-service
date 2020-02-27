class Reservation < ApplicationRecord
  belongs_to :fp_user
  belongs_to :user, optional: true

  validate :check_start_time

  def check_start_time
    if start_time.saturday?
      return if start_time.strftime("%H:%M") >= "11:00" && start_time.strftime("%H:%M") <= "14:30"
      errors.add(:start_time, "この時間は予約できません")
    elsif start_time.sunday?
      errors.add(:start_time, "日曜日は予約できません")
    else
      return if start_time.strftime("%H:%M") >= "10:00" && start_time.strftime("%H:%M") <= "17:30"
      errors.add(:start_time, "この時間は予約できません")
    end
  end
end
