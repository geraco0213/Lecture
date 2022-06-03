# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController


  skip_before_action :verify_authenticity_token, only: :create

  def create
    p "auth_hash", auth_hash
    p "info", auth_hash.info
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
  # before_action :configure_sign_in_params, only: [:create]
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def create_guest
    user = User.guest
    sign_in user   # ユーザーをログインさせる
    flash[:success]='ゲストユーザーとしてログインしました。'
    redirect_to root_url
  end
  
  def create_guest_admin
    user = User.guest_admin
    sign_in user   # ユーザーをログインさせる
    flash[:success]='ゲスト管理人としてログインしました。'
    redirect_to root_url
  end
  
  
  
  protected

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
end
