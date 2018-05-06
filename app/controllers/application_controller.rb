class ApplicationController < ActionController::Base 
  before_action :authorize
  def user_signed_in?
    session[:user_id].present?
  end

  def current_user
    user = User.find_by(id: session[:user_id]) 
  end
  helper_method :current_user
  helper_method :user_signed_in?

  protected
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in" 
    end
  end
end