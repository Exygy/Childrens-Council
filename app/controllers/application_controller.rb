class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # Remove CSRF protection for json requests
  # http://edgeapi.rubyonrails.org/classes/ActionController/RequestForgeryProtection.html
  protect_from_forgery unless: -> { request.format.json? }
end
