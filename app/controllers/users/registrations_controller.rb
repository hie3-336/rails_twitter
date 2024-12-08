# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    def create
      super
      create_internal
    end

    def update
      super
      destroy_internal
    end

    def create_internal; end

    def destroy_internal; end

    # POST /resource

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource

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

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    # The path used after sign up.
    def after_sign_up_path_for(_resource)
      tweets_path
    end

    # The path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(_resource)
      tweets_path
    end

    # hashをもとにresourceの新しいインスタンスを作る
    def build_resource(hash = {})
      hash[:uid] = User.create_unique_string
      super
    end

    # パスワードを変更する場合のみ本家メソッドを呼び、パスワードの変更を伴わない場合は、パスワードなしで更新できるように
    def update_resource(resource, params)
      return super if params['password'].present?
      resource.update_without_password(params.except('current_password'))
    end
  end
end
