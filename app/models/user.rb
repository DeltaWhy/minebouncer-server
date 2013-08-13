class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :password, presence: true
  validates :username, presence: true, format: /\A[^\s]+\z/


end
