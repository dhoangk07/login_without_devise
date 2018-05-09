class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, only: [:index]
  skip_before_action :authorize, only: [:forgot_password, :reset_password, :handle_forgot_password, :handle_reset_password ]
  include UsersHelper
  # GET /users
  # GET /users.json
  def index
    @users = User.order(:email)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User #{@user.email} was successfully created." }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "User #{@user.email} was successfully created." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    begin
      @user.destroy
      flash[:notice] = "User #{@user.email} deleted" 
    rescue StandardError => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to users_url } 
      format.json { head :no_content }
    end
  end

  def unlock
    @user = User.find_by(reset_token: params[:token])
    @user.sign_in_count = 0
    @user.save
    redirect_to login_path
  end

  def admin_only
    unless admin?
      redirect_to welcome_index_path, :alert => "Access denied."
    end
  end

  def forgot_password
    # user = User.find_by(email: params[:email])
    # UserMailer.forgot_password_email.deliver

  end

  def handle_forgot_password
    @email = params[:email]
    UserMailer.forgot_password_email(@email).deliver 
  end

  def reset_password

  end

  def handle_reset_password
    user = User.find_by(email: params[:email])
    if params[:password_confirmation] === params[:password]
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.save
      redirect_to login_path, :alert => "Reset Password succesful"
    else
      redirect_to reset_password_path, :alert => "Password must matched"
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
