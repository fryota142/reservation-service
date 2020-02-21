class Fpuser < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 64 }
  has_secure_password
end
