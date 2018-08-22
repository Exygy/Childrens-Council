# frozen_string_literal: true

class Parents::RegistrationsController < DeviseTokenAuth::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    byebug
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

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

  protected

  def build_resource
    @resource = Parent.find_by_api_key(params[:api_key]) if params[:api_key]
    if @resource.present?
      @resource.assign_attributes(sign_up_params)
    else
      @resource = resource_class.new(sign_up_params)
    end
    @resource.provider   = provider

    # honor devise configuration for case_insensitive_keys
    if resource_class.case_insensitive_keys.include?(:email)
      @resource.email = sign_up_params[:email].try(:downcase)
    else
      @resource.email = sign_up_params[:email]
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:api_key])
  end

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
