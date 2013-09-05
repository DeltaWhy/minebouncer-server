require 'spec_helper'

describe AvatarWorker do
  it "downloads an avatar for a user" do
    u = FactoryGirl.create(:user, username: "DeltaWhy")
    u.avatar.should be_blank
    AvatarWorker.new.perform(u.id)
    u.reload
    u.avatar.should_not be_blank
  end
end
