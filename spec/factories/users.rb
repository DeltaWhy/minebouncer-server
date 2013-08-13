# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "steve@example.com"
    password "password1"
    password_confirmation "password1"
    username "Steve"

    admin false
  end

  factory :admin, class: User do
    email "admin@example.com"
    password "password1"
    password_confirmation "password1"
    username "Admin"

    admin true
  end
end
