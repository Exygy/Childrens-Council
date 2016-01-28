module Api
  class ProviderController < ApplicationController
    def show
      provider = Provider.find(params[:id])
      render json: provider, status: 200
    end
  end
end
