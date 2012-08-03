class UsersController < ApplicationController
  include Gizmo

  def index
    render find_all(User.where({})).to_hash
  end

  def show
    render find(User, params[:id]).to_hash
  end

  def create
    render make(User, params).to_hash
  end
  def update
    render modify(User, params[:id], params).to_hash
  end

  def destroy
    render delete(User, params[:id]).to_hash
  end

end
