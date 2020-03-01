class Reservation < ApplicationRecord
  belongs_to :fp_user
  belongs_to :user, optional: true

  validate :check_start_time
  validate :check_double_booking

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

  def check_double_booking
    user_reservation = Reservation.find_by(user_id: user_id, start_time: start_time)
    return unless user_reservation.present?
    errors.add(:base, "他の予定と時間が重複しているため予約できません")
  end
end
