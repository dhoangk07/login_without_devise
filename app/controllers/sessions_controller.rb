class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :not_sign_in, only: [:new]
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present?
      if  user.sign_in_count >=3  
        UserMailer.lock_account_email(user).deliver
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
    else
      redirect_to login_url, alert: "Invalid user/password combination" 
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end

  def not_sign_in
    if current_user.present?
      redirect_to user_path(current_user)
    end
  end

  # def forgotten_password
  #   user = User.find_by(email: params[:email])
  #       debugger
  #   # UserMailer.forgotten_password_email.deliver
  # end

  # def reset_password
  #   # UserMailer.forgotten_password_email.deliver 

  # end
end
