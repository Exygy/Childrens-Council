module Api
  class ProvidersController < ApiKeyController
    def index
      providers = Provider.all

      # location
      providers = providers.where(zipcode: params[:zipcodes]) if params[:zipcodes]
      providers = providers.where(neighborhoods: params[:neighborhoods]) if params[:neighborhoods]
      providers = providers.near(params[:near_address], 20) if params[:near_address]

      # provider_type:
      # ages: will be an array containing the months
      # day and hours of care: day through joining table + info on joining table
      # summer_school: true
      # year_long: true
      # child_care_type: 1 - care_type_id
      # languages: [{language: "english", "fluent"}] languages through joining table + info (fluent...) on joining table
      # rate: shit show?
      # financial_assistance: [1,2,3] foreign_key
      # child_care_philisophie: [1,2,3] foreign_key
      # special_needs: [1,2,3] - foreign_key
      # meals_included: true - many to many but mainly is there any entry










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


    private


    def parent_params
      params.require(:parent).permit(:email, :first_name, :last_name)
    end

  end
end
