class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates  :email,     :presence   => true,
            :format                 => { with: VALID_EMAIL_REGEX },
            :uniqueness             => {:case_sensitive => false}

  validates  :password,  :presence   => true,
            :confirmation           => true,
            :length                 => {:within => 6..40}, :on => :create

  # Determine admin role for user
  # enum role: [:user, :vip, :admin]

  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :user
  # end

  has_secure_password

  has_secure_token :reset_token

  #send email for user after registration
  after_create :send_welcome_email
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
  
  after_destroy :ensure_an_admin_remains
  private
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end 
  end
end


