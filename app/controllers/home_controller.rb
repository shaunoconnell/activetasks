class HomeController < ApplicationController

  SMALL_SEED_COUNT = 5
  LARGE_SEED_COUNT = 20

  def index

  end

  def db_seed
    users = []
    SMALL_SEED_COUNT.downto(0) do |i|
      users << User.create({:name=>"fake_user_#{i}", :email=>"fake_user_#{i}@foo.com"})
    end

    activities = []
    SMALL_SEED_COUNT.downto(0) do |i|
      activity = Activity.new({:name=>"my #{i} activity"})
      activity.user = users[rand(SMALL_SEED_COUNT)]
      activity.follower_ids = [users[rand(SMALL_SEED_COUNT)].id]
      activity.save
      activities << activity
    end

    LARGE_SEED_COUNT.downto(0) do |i|
      post = ActivityPost.new({:description=> "the #{i} entry"})
      post.activity = activities[rand(SMALL_SEED_COUNT)]
      post.save
    end

    render :json => {}
  end

  def db_clear
    ActivityPost.destroy_all
    Activity.destroy_all
    User.destroy_all
    render :json => {}
  end
end
