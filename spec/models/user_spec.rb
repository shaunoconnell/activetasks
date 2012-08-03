require 'spec_helper'

describe User do
  before(:each)do
    User.destroy_all
    @user = FactoryGirl.create(:user)
  end

  after(:each) do
    User.destroy_all
  end

  it "user should require email address" do
    @user.valid?.should be_true
    @user.email = nil
    @user.valid?.should be_false
  end
end
