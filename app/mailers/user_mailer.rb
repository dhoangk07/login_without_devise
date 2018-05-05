class UserMailer < ApplicationMailer
  default :from => "walter@vinova.sg"
 
  def welcome_email(user)
    @user = user
    @url  = "http://gmail.com/login"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end

  def lock_account_email(user)
    @user = user
    mail(:to => user.email, :subject => "Your account on example.com already locked")
  end
end