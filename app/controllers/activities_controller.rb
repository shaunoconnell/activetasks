class ActivitiesController < ApplicationController
  include Gizmo

  def index
    activities = Activity.where({:user_id=>params[:user_id]})
    if activities.nil?  || activities.count == 0
      render_404
    else
      render find_all(activities).to_hash
    end
  end

  def show
    activity = Activity.where({:user_id=>params[:user_id]})
    if activity.nil?
        render_404
    else
        render find(activity,params[:id]).to_hash
    end
  end

  def create
    url_proc = Proc.new do |id|
      user_activity_url(params[:user_id],id)
    end
    render make(Activity, params, url_proc).to_hash
  end

  def update
    activity = Activity.where({:user_id=>params[:user_id]})
    render modify(activity, params[:id], params).to_hash
  end

  def destroy
    activities = Activity.where({:user_id=>params[:user_id]})
    render delete(activities, params[:id]).to_hash
  end
end
