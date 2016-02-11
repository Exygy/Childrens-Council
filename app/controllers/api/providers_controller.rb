module Api
  class ProvidersController < ApiKeyController



    def index
      providers = Provider.all

      # location
      providers = providers.search_by_zipcode_ids(params[:zipcode_ids]) if params[:zipcode_ids]
      providers = providers.search_by_neighborhood_ids(params[:neighborhood_ids]) if params[:neighborhood_ids] #array of ids
      providers = providers.near(params[:near_address], 20) if params[:near_address] #string

      # provider_type:
      # ages: will be an array containing the months
      providers = providers.search_by_ages(params[:ages]) if params[:ages] #array of interger = months

      # day and hours of care: day through joining table + info on joining table
      # open_days: [{start_time: '08:00:00', end_time: '17:00:00', schedule_day_id: 1}, {start_time: '08:00:00', end_time: '17:00:00', schedule_day_id: 2}]

      providers = providers.search_by_days_and_hours(params[:open_days]) if params[:open_days] #array of interger = months

      # summer_school OR year_long
      providers = providers.search_by_schedule_year_ids(params[:schedule_year_ids]) if params[:schedule_year_ids] #array of ids

      # child_care_type: 1 - care_type_id
      providers = providers.search_by_care_type_ids(params[:care_type_ids]) if params[:care_type_ids] #array of ids

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
