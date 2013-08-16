# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    user
    host "localhost"
    port 25565
    motd "Player - test game"
  end
end
