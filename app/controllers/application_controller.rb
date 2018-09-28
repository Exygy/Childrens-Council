class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found
  # rescue_from Rack::Timeout::RequestTimeoutError,
  #             Rack::Timeout::RequestExpiryError,
  #             with: :handle_timeout

  protected

  # def handle_timeout(exception)
  #   # Send exception report to service for tracking
  #
  #   # If the timeout occurs during the middle of a MySQL query, we need to cancel the
  #   # query so that "Mysql2::Error: closed MySQL connection" isn't raised in the middle
  #   # of a subsequent request
  #   ActiveRecord::Base.connection.reset!
  #
  #   # Render error page
  #   respond_with_error_status(503)
  # end

  private

  def set_csrf_cookie
    return unless protect_against_forgery?
    cookies['XSRF-TOKEN'] = form_authenticity_token
  end

  def render_not_found
    head 404
  end

  def render_unauthorized
     head 401
  end
end
