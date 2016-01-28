module Api
  class CorsController < ApplicationController
    def render_204
      head 204
    end
  end
end
