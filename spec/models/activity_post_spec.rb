require 'spec_helper'

describe ActivityPost do
  before(:each) do
    @activity_post.delete unless @activity_post.nil?
    @activity_post = FactoryGirl.create(:activity_post)
  end
  after(:each) do
    @activity_post.delete unless @activity_post.nil?
  end

  #silly test, sample for when we have real behavior
  it "should have a timestamp saved" do
    activity_post = ActivityPost.find(@activity_post.id)
    activity_post.created_at.should_not be_nil
    activity_post.updated_at.should_not be_nil
    original_updated_at = activity_post.updated_at

    #sleep 5
    activity_post.description = "new desc"
    activity_post.save

    activity_post = ActivityPost.find(@activity_post.id)
    activity_post.updated_at.should_not == original_updated_at
  end
end
