require 'spec_helper'

describe User do
  it "validates email" do
    @user = User.new(password: "password1", password_confirmation: "password1", username: "Steve")
    @user.should_not be_valid
    @user.email = "not an email"
    @user.should_not be_valid
    @user.email = "steve@example.com"
    @user.should be_valid
  end
end
