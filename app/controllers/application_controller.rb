class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from ActionController::Unauthorized, with: :render_unauthorized

  private

  def set_csrf_cookie
    return unless protect_against_forgery?
    cookies['XSRF-TOKEN'] = form_authenticity_token
  end

  def render_not_found
    render_json
    {
      status: 404,
      message: 'The requested resource could not be found',
    }
  end

  def render_unauthorized
    render_json
    {
      status: 401,
      message: 'Unauthorized API key',
    }
  end

  private

  def render_json(hash)
    render json: hash, status: hash.status
  end
end
