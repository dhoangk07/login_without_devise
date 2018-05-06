class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates  :email,     :presence   => true,
            :format                 => { with: VALID_EMAIL_REGEX },
            :uniqueness             => {:case_sensitive => false}

  validates  :password,  :presence   => true,
            :confirmation           => true,
            :length                 => {:within => 6..40}, :on => :create

  has_secure_password

  has_secure_token :reset_token

  after_destroy :ensure_an_admin_remains

  after_create :send_welcome_email
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end 
  end
end


