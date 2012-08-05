class PostsController < ApplicationController
  include Gizmo

  def index
    posts = ActivityPost.where({:activity_id => params[:activity_id]})
    if posts.nil? || posts.count == 0
      render_404
    else
      render find_all(posts).to_hash
    end
  end

  def show
    post = ActivityPost.where({:activity_id => params[:activity_id]})
    if post.nil?
      render_404
    else
      render find(post, params[:id]).to_hash
    end
  end

  def create
    url_proc = Proc.new do |id|
      activity_post_url(params[:activity_id], id)
    end
    render make(ActivityPost, params, url_proc).to_hash
  end

  def update
    post = ActivityPost.where({:activity_id => params[:activity_id]})
    render modify(post, params[:id], params).to_hash
  end

  def destroy
    posts = ActivityPost.where({:activity_id => params[:activity_id]})
    render delete(posts, params[:id]).to_hash
  end
end
