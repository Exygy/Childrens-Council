module Api
  class ProvidersController < ApiKeyController
    def index
      providers = Provider.all
      providers = providers.search_by_zipcode_ids(params[:zipcode_ids]) if params[:zipcode_ids]
      providers = providers.search_by_neighborhood_ids(params[:neighborhood_ids]) if params[:neighborhood_ids]
      providers = providers.near(params[:near_address], 20) if params[:near_address]
      providers = providers.search_by_ages(params[:ages]) if params[:ages]
      providers = providers.search_by_days_and_hours(params[:open_days]) if params[:open_days]
      providers = providers.search_by_schedule_year_ids(params[:schedule_year_ids]) if params[:schedule_year_ids]
      providers = providers.search_by_care_type_ids(params[:care_type_ids]) if params[:care_type_ids]

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
      params.permit(:zipcode_ids, :neighborhood_ids, :near_address, :ages, :open_days, :schedule_year_ids, :care_type_ids)
    end
  end
end
