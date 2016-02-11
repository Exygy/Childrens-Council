module Api
  class ProvidersController < ApiKeyController
    def index







      providers = Provider.all












      provider_count = providers.count
      render json: {
        total: provider_count,
        providers: providers.page(params[:page]).per(params[:per_page]),
      }, status: 200
    end

    def show
      provider = Provider.find(params[:id])
      render json: provider, status: 200
    end
  end
end
