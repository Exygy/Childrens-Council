module Api
  class ProvidersController < ApiKeyController
    def index
      providers = Provider.all

      # location
      providers = providers.where{ zip_code_id.in( my{params[:zipcodes]} ) } if params[:zipcodes] #array of ids
      #providers = providers.where(neighborhoods: params[:neighborhoods]) if params[:neighborhoods] #array of ids
      providers = providers.near(params[:near_address], 20) if params[:near_address] #string





      # provider_type:
      # ages: will be an array containing the months

      providers = providers.where("ages @> ?", '{8, 9, 10}') if params[:ages]

      # day and hours of care: day through joining table + info on joining table
      params[:open_days] =

      [
        {start_time: '08:00:00', end_time: '17:00:00', schedule_day_id: 1},
        {start_time: '08:00:00', end_time: '17:00:00', schedule_day_id: 2}
      ]


      if !params[:open_days].blank
        providers = providers.joins{schedule_hours}
        params[:open_days].each do |day_params|
          if day_params.has_key?(:start_time) and day_params.has_key?(:end_time) and day_params.has_key?(:schedule_day_id)
            providers = providers.where{
                (schedule_hours.start_time == my{day_params[:start_time]})
              & (schedule_hours.end_time == my{day_params[:end_time]})
              & (schedule_hours.schedule_day_id == my{day_params[:schedule_day_id]})
            }
          end
        end
      end

      # summer_school OR year_long: true
      providers = providers.where(schedule_year_id: params[:schedule_year_id]) if params[:schedule_year_id]

      # child_care_type: 1 - care_type_id
      providers = providers.where(care_type_id: params[:care_type_id]) if params[:care_type_id]

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
