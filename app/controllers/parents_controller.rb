class ParentsController < ApplicationController
  def create
    parent = Parent.new(parent_params)
    if parent.save
      render json: parent, status: 201
    else
      render json: { errors: parent.errors }, status: 422
    end
  end

  private
    def parent_params
      params.require(:parent).permit(:email, :first_name, :last_name)
    end
end
