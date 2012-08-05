require 'spec_helper'

describe Activity do
 before(:each) do
   @activity.delete unless @activity.nil?
   @activity = FactoryGirl.create(:activity)
 end
 after(:each) do
   @activity.delete unless @activity.nil?
 end

 it "should require a name" do
   @activity.valid?.should be_true
   @activity.name = nil
   @activity.valid?.should be_false
 end

  it "should require a user" do
    new_activity = FactoryGirl.build(:activity)
    new_activity.user = nil
    new_activity.valid?.should be_false
  end

end
