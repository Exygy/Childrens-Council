module Api
  class FavoritesController < ApiController
    include CollectReferrals
    before_action :authorize_parent

    def create
      @favorite = Favorite.create!(favorite_params.merge(parent_id: @current_parent.id))

      render json: results
    end

    def destroy
      @favorite = @current_parent.favorites.find_by_provider_id(params[:id])
      @favorite.destroy

      render json: @favorite
    end

    private

    def authorize_parent
      raise_not_authorized! if @current_parent.blank? || @current_parent.encrypted_password.blank?
    end

    def favorite_params
      params.require(:favorite).permit(:provider_id)
    end

  end
end
