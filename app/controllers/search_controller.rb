class SearchController < ApplicationController
  def search
    # Get existing record using email as key
    if parent = Parent::where({email: params[:parent][:email]}).first
      status_code = 200
    else
      parent = Parent.new
      status_code = 201
    end

    if parent.update(parent_params)
      render json: parent, status: status_code
    else
      render json: { errors: parent.errors }, status: 422
    end
  end

  private
    def parent_params
      params.require(:parent).permit(:email, :first_name, :last_name)
    end
end
