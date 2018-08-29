# frozen_string_literal: true

class Parents::PasswordsController < DeviseTokenAuth::PasswordsController
  before_action :find_resource_by_reset_token, only: [:update]
  before_action :set_default_response_format
  after_action :set_allow_password_change, only: [:create]

  protected

  def find_resource_by_reset_token
    @resource = with_reset_password_token(resource_params[:reset_password_token])
  end

  def set_default_response_format
    request.format = :json
  end

  def set_allow_password_change
    if @resource && @resource.reset_password_token.present?
      @resource.update_attribute(:allow_password_change, true)
    end
  end
end
