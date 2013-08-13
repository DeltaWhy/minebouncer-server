# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "MyString"
    password_digest "MyString"
    reset_password_token "MyString"
    reset_password_sent_at "2013-08-13 09:20:11"
    confirmation_token "MyString"
    confirmed_at "2013-08-13 09:20:11"
    confirmation_sent_at "2013-08-13 09:20:11"
    unconfirmed_email "MyString"
    admin false
  end
end
