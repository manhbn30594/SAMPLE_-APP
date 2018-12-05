class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "notifi.info_email"
      redirect_to root_url
    else
      flash.now[:danger] = t "notifi.danger_email"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("notifi.update_error")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update :reset_digest, nil
      flash[:success] = t "notifi.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation, :remember_digest
  end

  def load_user
    @user = User.find_by email: params[:email]

    return if @user
    flash[:danger] = t "notifi.show"
    redirect_to root_url and return unless true
  end

  def valid_user
    unless @user && @user.activated? &&
      @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t "notifi.password_danger"
      redirect_to new_password_reset_url
    end
  end
end
