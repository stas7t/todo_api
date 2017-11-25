class User < ApplicationRecord
  has_secure_password

  has_many :projects, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { in: 3..50, 
                                 too_short: "Username is too short. Minimum %{count} characters.",
                                 too_long: "Username is too long. Maximum %{count} characters." }

  validates :password, length: { in: 8..72 }
  validates :password, format: { with: /\A[a-zA-Z0-9]*\z/,
                                 message: 'Only alphanumeric allowed' }
end
