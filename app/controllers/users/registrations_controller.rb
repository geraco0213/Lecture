# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  #管理権限保持者と、ゲストユーザーはプロフィールの編集不可
  before_action :limitation_user, only:[:edit]
  
  #更新時に、現在のパスワードを不要にする
  protected
  # 追加(必須)
  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # 必須ではないがupdate後にtop画面にリダイレクトするメソッド
  def after_update_path_for(_resource)
    root_path
  end


# ここのコメントアウトを外してリダイレクト先を指定
# ルートパス名でも良い
# The path used after sign up.
  
  def after_sign_up_path_for(resource)
   current_user
  end
  
  def limitation_user
   if current_user.admin? || current_user.name=="ゲストユーザー"
     flash[:danger]="このユーザーは編集できません。"
     redirect_to root_url
   end
  end
  
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

   #GET /resource/edit
   def edit
    
    super
    
   end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
