class User < ActiveRecord::Base
  has_secure_password
  has_many :games

  validates :email, presence: true, uniqueness: true, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :username, presence: true, uniqueness: true, format: /\A[A-Za-z0-9_]+\z/

  mount_uploader :avatar, AvatarUploader

  def confirmed?
    !!confirmed_at
  end
end
