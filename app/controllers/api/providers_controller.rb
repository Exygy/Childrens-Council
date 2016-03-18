module Api
  class ProvidersController < ApiController
    def index
      providers = Provider.includes(:schedule_hours)
      providers = providers.search_by_zipcode_ids(provider_param_zipcode_ids) if provider_param_zipcode_ids
      providers = providers.search_by_neighborhood_ids(provider_param_neighborhood_ids) if provider_param_neighborhood_ids
      providers = providers.near(provider_param_near_address, 20) if provider_param_near_address
      providers = providers.search_by_ages(provider_param_ages) if provider_param_ages
      providers = providers.search_by_days_and_hours(provider_param_open_days) if provider_param_open_days
      providers = providers.search_by_languages(provider_param_languages) if provider_param_languages
      providers = providers.search_by_schedule_year_ids(provider_param_schedule_year_ids) if provider_param_schedule_year_ids
      providers = providers.search_by_care_type_ids(provider_param_care_type_ids) if provider_param_care_type_ids

      # languages: [{language: "english", "fluent"}] languages through joining table + info (fluent...) on joining table
      # rate: shit show?
      # financial_assistance: [1,2,3] foreign_key
      # child_care_philisophie: [1,2,3] foreign_key
      # special_needs: [1,2,3] - foreign_key
      # meals_included: true - many to many but mainly is there any entry

      provider_count = providers.size
      render json: {
        total: provider_count,
        providers: providers.page(params[:page]).per(params[:per_page]),
      }, status: 200
    end

    def show
      provider = Provider.eager_load(:language_providers, :schedule_hours, :schedule_week, :schedule_days, :licenses).find(params[:id])
      render json: ProviderSerializer.new(provider), status: 200
    end

    private

    def provider_params
      params.require(:providers).permit(
        :near_address,
        ages: [],
        care_type_ids: [],
        language_ids: [],
        neighborhood_ids: [],
        open_days: [],
        schedule_year_ids: [],
        zipcode_ids: [],
      )
    end

    def method_missing(method_sym, *arguments, &block)
      method_name_prefix = 'provider_param_'
      if method_sym[0..method_name_prefix.length - 1] == method_name_prefix
        param = method_sym[method_name_prefix.length..method_sym.length]
        !provider_params[param.to_sym].blank? ? provider_params[param.to_sym] : false
      else
        super
      end
    end
  end
end
