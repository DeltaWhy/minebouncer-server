class GameSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :host, :port, :motd
end
