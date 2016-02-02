module Api
  class SearchController < ApplicationController
    def search
      render json: { goog: true }, status: 200
      # parent = Parent.first_or_new(parent_params)
      #
      # if parent.update(parent_params)
      #   render json: parent, status: 200
      # else
      #   render json: { errors: parent.errors }, status: 422
      # end
    end

    private

    def parent_params
      params.require(:parent).permit(:email, :first_name, :last_name)
    end
  end
end
