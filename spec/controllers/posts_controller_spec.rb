require 'spec_helper'

describe PostsController do
  before(:each) do

    ActivityPost.destroy_all
    Activity.destroy_all
    User.destroy_all
    @user = FactoryGirl.create(:user)
    @activity_one = FactoryGirl.create(:activity, {:user => @user})
    @post_one = FactoryGirl.create(:activity_post, {:activity => @activity_one})
    @post_two = FactoryGirl.create(:activity_post, {:activity => @activity_one})
  end


  after(:each) do
    ActivityPost.destroy_all
    Activity.destroy_all
    User.destroy_all
  end

  context "GET #index" do
    it "should find all posts for a activity" do
      json = {:format => :json, :activity_id => @activity_one.id}
      get :index, json
      response.status.should == 200
      json_result = JSON.parse(response.body)
      json_result.should_not be_nil
      json_result.count.should == 2
    end

    it "should return 404 if no posts are associated with a activity" do
      new_activity = FactoryGirl.create(:activity, {:user=>@user})
      json = {:format => :json, :activity_id => new_activity.id}
      get :index, json
      response.status.should == 404
    end
  end

  context "GET #show" do
    it "should find a single post" do
      json = {:format => :json, :id => @post_one.id, :activity_id => @post_one.activity_id}

      get :show, json
      response_hash = JSON.parse(response.body)
      response_hash.should_not be_nil
      response_hash['description'].should eq(@post_one.description)
    end

    it "should return 404 for invalid activity" do
      json = {:format => :json, :id => @post_one.id, :activity_id => FactoryGirl.build(:activity).id}

      get :show, json
      response.status.should == 404
    end

    it "should return 404 for invalid post.id" do
      json = {:format => :json, :id => FactoryGirl.build(:activity_post).id, :activity_id => @activity_one.id}

      get :show, json
      response.status.should == 404
    end
  end

  context "POST #create" do
    it "should properly create a new post" do
      unsaved_post = FactoryGirl.build(:activity_post)
      json = unsaved_post.attributes.merge({:format => :json})

      post :create, json
      response.status.should == 201
      new_id = JSON.parse(response.body)["_id"]

      post = ActivityPost.find(new_id)
      post.should_not be_nil

    end

    it "should not create a post with an invalid activity" do
      unsaved_activity = FactoryGirl.build(:activity)
      unsaved_post = FactoryGirl.build(:activity_post)
      json = unsaved_post.attributes.merge({:format => :json})
      json["activity_id"] = unsaved_activity.id

      post :create, json
      response.status.should == 422

      errors_json = JSON.parse(response.body)
      errors_json["activity"].should_not be_nil
    end
  end

  context "PUT #update" do
    it "should properly update an existing post" do
      post = ActivityPost.first
      post.description = "my new name"
      json = post.attributes.merge({:format => :json})

      put :update, json.merge({"id" => post.id})
      response.status.should eq(200)

      result_json = JSON.parse(response.body)
      result_json["description"].should == "my new name"

      post = ActivityPost.find(post.id)
      post.description.should == "my new name"

    end
  end

  context "DELETE #destroy" do
    it "should remove an existing entity" do
      post = ActivityPost.first
      json = {:format => :json, :id => post.id, :activity_id => post.activity_id}

      delete :destroy, json

      response.status.should == 200
      ActivityPost.where({:id => post.id}).count.should == 0

    end

    it "should return 404 if there is not entity to destroy" do
      unsaved_post = FactoryGirl.build(:activity_post)
      json = {:format => :json, :id => unsaved_post.id, :activity_id => unsaved_post.activity_id}

      delete :destroy, json
      response.status.should == 404

    end
  end
end
