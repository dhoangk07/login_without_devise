module SessionsHelper
  def user_signed_in?
    session[:user_id].present?
  end

  def current_user
    user = User.find_by(id: session[:user_id]) 
  end
end