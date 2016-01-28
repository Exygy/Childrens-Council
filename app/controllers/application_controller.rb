class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  after_action :set_csrf_cookie

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found

  protected

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  private

  def set_csrf_cookie
    return unless protect_against_forgery?
    cookies['XSRF-TOKEN'] = form_authenticity_token
  end

  def render_not_found
    hash =
      {
        status: 404,
        message: 'The requested resource could not be found.',
      }
    render json: hash, status: 404
  end
end
