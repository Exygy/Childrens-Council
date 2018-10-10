module Api
  class FavoritesController < ApiController
    skip_before_action :check_parent_credentials
    before_action :set_parent

    def index
      @scope = @resource.favorites.page((params[:page].to_i + 1) || 1).per(10)
      @results = NDS.search_providers_bulk(providerIds: @scope.collect(&:provider_id))

      @results[:content].each do |provider|
        provider[:images] = providers_images[provider["providerId"].to_s] unless Rails.env.development?
        provider[:favorite] = true
      end if @results
      set_meta_data
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

    def set_meta_data
      @results['totalElements'] = @resource.favorites.count
      @results['numberOfElements'] = 10
      @results['number'] = params[:page].to_i || 0
      @results['totalPages'] = @scope.total_pages - 1
    end

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
