module Api
  class FavoritesController < ApiController
    skip_before_action :check_parent_credentials
    before_action :set_user_by_token
    before_action :set_parent

    def index
      @results = []
      # TODO this cant't be like that. We need to modify the query to get all providers at once
      @resource.favorites.order('created_at DESC').each do |favorite|
        provider = NDS.provider_by_id(favorite.provider_id)
        provider[:images] = provider_images(favorite.provider_id)
        provider[:favorite] = true
        @results << provider
      end
      render json: @results
    end

    def create
      @favorite = Favorite.create!(favorite_params.merge(parent_id: @resource.id))

      render json: @favorite
    end

    def destroy
      @favorite = @resource.favorites.find_by_provider_id(params[:id])
      @favorite.destroy

      render json: @favorite
    end

    private

    def set_parent
      @current_parent = @resource
    end

    def favorite_params
      params.require(:favorite).permit(:provider_id)
    end

    def provider_images(provider_id)
      ProviderImageService.get(provider_id)
    end
  end
end
