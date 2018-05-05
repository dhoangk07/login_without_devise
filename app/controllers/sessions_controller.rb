class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user.present?
      if  user.sign_in_count >=3  
        redirect_to login_url, alert: "User has login more than 3 times" 
      else
        if user.authenticate(params[:password])
          user.sign_in_count = 0
          user.save
          session[:user_id] = user.id
          redirect_to admin_url
        else
          user.sign_in_count += 1 
          user.save
          redirect_to login_url, alert: "Invalid user/password combination" 
        end
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end

end
