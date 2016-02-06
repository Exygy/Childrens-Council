module Api
  class ApiKeyController < ApplicationController
    before_action :check_api_key

    def check_api_key
      if params[:key]
        parents = Parent.where(api_key: params[:key])
        if parents.count == 1
          @current_parent = parents.first
        else
          raise_not_authorized!
        end
      else
        raise_not_authorized!
      end
    end

    private

    def raise_not_authorized!
      fail ActionController::Unauthorized
    end
  end
end
