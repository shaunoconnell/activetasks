require 'spec_helper'

describe ActivitiesController do
  before(:each) do

    Activity.destroy_all
    User.destroy_all
    @user = FactoryGirl.create(:user)
    @activity_one = FactoryGirl.create(:activity, {:user => @user})
    @activity_two = FactoryGirl.create(:activity, {:user => @user})
  end

  after(:each) do
    Activity.destroy_all
    User.destroy_all
  end

  context "GET #index" do
    it "should find all activities for a user" do
      json = {:format => :json, :user_id => @activity_one.user_id}
      get :index, json
      response.status.should == 200
      json_result = JSON.parse(response.body)
      json_result.should_not be_nil
      json_result.count.should == 2
    end

    it "should return 404 if no activites are associated with a user" do
      user = FactoryGirl.create(:user)
      json = {:format => :json, :user_id => user.id}
      get :index, json
      response.status.should == 404
    end
  end

  context "GET #show" do
    it "should find a single activity" do
      json = {:format => :json, :id => @activity_one.id, :user_id => @activity_one.user_id}

      get :show, json
      response_hash = JSON.parse(response.body)
      response_hash.should_not be_nil
      response_hash['name'].should eq(@activity_one.name)
    end

    it "should return 404 for invalid user" do
      json = {:format => :json, :id => @activity_one.id, :user_id => FactoryGirl.build(:user).id}

      get :show, json
      response.status.should == 404
    end

    it "should return 404 for invalid activity.id" do
      json = {:format => :json, :id => FactoryGirl.build(:activity).id, :user_id => @activity_one.user_id}

      get :show, json
      response.status.should == 404
    end
  end

  context "POST #create" do
    it "should properly create a new activity" do
      unsaved_activity = FactoryGirl.build(:activity)
      json = unsaved_activity.attributes.merge({:format => :json})

      post :create, json
      response.status.should == 201
      new_id = JSON.parse(response.body)["_id"]

      activity = Activity.find(new_id)
      activity.should_not be_nil

    end

    it "should not create an activity with an invalid user" do
      unsaved_user = FactoryGirl.build(:user)
      json = @activity_one.attributes.merge({:format=>:json})
      json["user_id"] = unsaved_user.id

      post :create, json
      response.status.should == 422

      errors_json = JSON.parse(response.body)
      errors_json["user"].should_not be_nil
    end
  end

  context "PUT #update" do
    it "should properly update an existing activity" do
      activity = Activity.first
      activity.name = "my new name"
      json = activity.attributes.merge({:format => :json})

      put :update, json.merge({"id" => activity.id})
      response.status.should eq(200)

      result_json = JSON.parse(response.body)
      result_json["name"].should == "my new name"

      activity = Activity.find(activity.id)
      activity.name.should == "my new name"

    end
  end

  context "DELETE #destroy" do
    it "should remove an existing entity" do
      activity = Activity.first
      json = {:format=>:json, :id=>activity.id, :user_id=>activity.user_id}

      delete :destroy, json

      response.status.should == 200
      Activity.where({:id=>activity.id}).count.should == 0

    end

    it "should return 404 if there is not entity to destroy" do
      unsaved_activity = FactoryGirl.build(:activity)
      json = {:format=>:json, :id=>unsaved_activity.id, :user_id=>unsaved_activity.user_id}

      delete :destroy, json
      response.status.should == 404

    end
  end
end
