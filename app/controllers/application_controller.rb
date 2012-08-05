class ApplicationController < ActionController::Base
  #TODO: do some security
  #protect_from_forgery

  rescue_from Mongoid::Errors::DocumentNotFound, :with=>:render_404
  rescue_from Mongoid::Errors::Validations, :with=>:render_unprocessable

  protected
  def render_404
    render :json=>{}, :status=>404
  end

  def render_unprocessable(ex)
    render :json=>ex.document.errors, :status=>:unprocessable_entity
  end
end
