module Api
  class FavoritesController < ApiController
    include CollectReferrals

    def create
      @favorite = Favorite.create!(favorite_params.merge(parent_id: @current_parent.id))

      render json: @favorite
    end

    def destroy
      @favorite = @current_parent.favorites.find_by_provider_id(params[:id])
      @favorite.destroy

      render json: @favorite
    end

    private

    def favorite_params
      params.require(:favorite).permit(:provider_id)
    end

  end
end
