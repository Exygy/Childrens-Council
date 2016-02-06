module Api
  class ErrorsController < ApplicationController
    def raise_not_found!
      fail ActionController::RoutingError
    end
  end
end
