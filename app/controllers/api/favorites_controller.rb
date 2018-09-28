module Api
  class FavoritesController < ApiController
    skip_before_action :check_parent_credentials
    before_action :set_parent

    def index
      @results = NDS.search_providers_bulk(providerIds: @resource.favorites.collect(&:provider_id))
      @results.each do |provider|
        provider[:images] = providers_images[provider["providerId"].to_s]
        provider[:favorite] = true
      end if @results
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
      render_unauthorized unless @resource
      @current_parent = @resource
    end

    def favorite_params
      params.require(:favorite).permit(:provider_id)
    end

    def provider_ids
      @results.collect{ |provider_data| provider_data["providerId"] }
    end

    def providers_images
      @providers_images ||= ProviderImageService.get(provider_ids)
    end
  end
end
