module Api
  class ErrorsController < ApplicationController
    def raise_not_found!
      render_not_found
    end
  end
end
