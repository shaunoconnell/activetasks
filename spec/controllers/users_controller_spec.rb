require 'spec_helper'

describe UsersController do

  before(:each) do
    User.destroy_all
    @user_one = FactoryGirl.create(:user)
    @user_two = FactoryGirl.create(:user)
  end

  after(:each) do
    User.destroy_all
  end

  context "GET #index" do
  it "should get all users" do

    #json = { :format => 'json', :application => { :name => "foo", :description => "bar" } }
    json = {:format => :json}
    get :index, json

    response.status.should == 200
    json_result = JSON.parse(response.body)
    json_result.should_not be_nil
    json_result.count.should == 2

  end
  end

  context "POST #create" do
    it "should create a user" do
      unsaved_user = FactoryGirl.build(:user)
      json = unsaved_user.attributes.merge({:format=>:json})

      post :create, json

      response.status.should == 201
      json_result = JSON.parse(response.body)
      json_result.should include("_id")

      saved_user = User.where({:_id => json_result["_id"]}).first
      saved_user.should_not be_nil
    end
  end

  context "PUT #update" do
    it "should properly update an existing model" do
      @user_one.email = "more_#{@user_one.email}"
      json = @user_one.attributes.merge({:format=>:json})

      put :update, json.merge(:id=>@user_one.id)
      response.status.should == 200

      new_user_one = User.find(@user_one.id)
      new_user_one.email.should eq(@user_one.email)
    end
  end

  context "DELETE #destroy" do
    it "should remove a model" do
      User.all.count.should == 2

      user_to_delete = User.first
      delete :destroy, :id =>user_to_delete.id, :format=>:json

      user = User.where({:id=>user_to_delete.id}).first
      user.should be_nil
      User.all.count.should == 1

    end
  end

  context "GET #show" do
    it "should return 404 if none is found" do
      unsaved_user = FactoryGirl.build(:user)

      get :show, :id=>unsaved_user.id, :format=>:json
      response.status.should == 404

    end

    it "should find a single user" do

      get :show, :id => @user_one.id, :format=>:json
      response.status.should == 200

      response_hash = JSON.parse(response.body)
      response_hash.should_not be_nil
      response_hash['email'].should eq(@user_one.email)

    end
  end


end