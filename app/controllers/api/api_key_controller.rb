module Api
  class ApiKeyController < ApplicationController
    before_action :check_api_key

    def check_api_key
      if params[:key]
        check_api_key
      elsif params[:parent]
        check_parent_credentials
      else
        raise_not_authorized!
      end
    end

    private

    def check_api_key
      # parents = Parent.where(api_key: params[:key])
      # if parents.count == 1
      #   @current_parent = parents.first
      # else
      #   raise_not_authorized!
      # end
    end

    def check_parent_credentials
      # parents = Parent.find_or_create_by(api_key: params[:key])
      # if parents.count == 1
      #   @current_parent = parents.first
      # else
      #   raise_not_authorized!
      # end
    end

    def raise_not_authorized!
      # render_unauthorized
    end
  end
end
