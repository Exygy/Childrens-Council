class Api::ApiBaseController < ApplicationController
  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.
  def cors_preflight_check
    return unless request.method == 'OPTIONS'
    cors_set_access_control_headers
    render text: '', content_type: 'text/plain'
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin']    = '*'
    headers['Access-Control-Allow-Methods']   = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method']  = '*'
    headers['Access-Control-Allow-Headers']   = 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-CSRF-Token'
    headers['Access-Control-Max-Age']         = '1728000'
  end
end
