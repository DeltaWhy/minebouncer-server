class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :avatar

  def avatar
    object.avatar.as_json[:avatar]
  end
end
