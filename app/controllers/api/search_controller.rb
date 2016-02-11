module Api
  class SearchController < ApplicationController
    def search
      providers = Provider.all
      provider_count = providers.count
      render json: {
        total: provider_count,
        providers: providers.page(params[:page]).per(params[:per_page]),
      }, status: 200
    end

    private

    def parent_params
      params.require(:parent).permit(:email, :first_name, :last_name)
    end
  end
end
