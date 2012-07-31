class PostsController < ApplicationController

  def index
    posts = ActivityPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: posts }
    end
  end

  def show
    post = ActivityPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: post }
    end
  end

  def create
    post = ActivityPost.new(params[:post])

    respond_to do |format|
      if post.save
        format.html { redirect_to post, notice: 'Post was successfully created.' }
        format.json { render json: post, status: :created, location: post }
      else
        format.html { render action: "new" }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    post = ActivityPost.find(params[:id])

    respond_to do |format|
      if post.update_attributes(params[:post])
        format.html { redirect_to post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    post = ActivityPost.find(params[:id])
    post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
