class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true, format: /\A[^\s]+\z/

  def confirmed?
    !!confirmed_at
  end
end
