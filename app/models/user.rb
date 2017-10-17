class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { in: 3..50 }

  validates :password_digest, length: { in: 8..72 }
  validates :password_digest, format: { with: /\A[a-zA-Z0-9]*\z/,
                                        message: 'Only alphanumeric allowed' }
end
