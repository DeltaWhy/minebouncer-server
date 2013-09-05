class AvatarWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    user.remote_avatar_url = "http://s3.amazonaws.com/MinecraftSkins/#{user.username}.png"
    user.avatar.store!
    user.save!
  end
end
