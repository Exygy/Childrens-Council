# frozen_string_literal: true

class Parents::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  after_action :send_welcome_email, only: [:create]
  before_action :set_default_response_format

  rescue_from 'ActiveRecord::RecordNotUnique' do |exception|
    clean_up_passwords @resource
    render_create_error_email_already_exists
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

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

  def set_default_response_format
    request.format = :json
  end

  def build_resource
    find_or_create_resource(params[:api_key])
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

  def configure_account_update_params
    params[:current_password] ||= true if @resource.email != params[:email]
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :phone, :home_zip_code, :full_name, :current_password])
  end

  def find_or_create_resource(api_key)
    @resource = Parent.find_by_api_key(api_key) if api_key
    if @resource.present?
      # If password is set, user is already signed in
      if @resource.encrypted_password.present?
        raise ActiveRecord::RecordNotUnique, "That email is already registered"
      else
        @resource.assign_attributes(sign_up_params)
      end
    else
      @resource = resource_class.new(sign_up_params)
    end
  end

  def send_welcome_email
    ParentMailer.welcome_email(@resource.id).deliver_now if @resource.id.present?
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
