module Api
  class ProvidersController < ApiController
    before_action :create_referral_log, only: :index

    def index
      providers = Provider.accepting_referrals.active
      providers = providers.where(co_op: provider_param_co_op) if provider_param_co_op
      providers = providers.where(potty_training: provider_param_potty_training) if provider_param_potty_training
      providers = providers.search_by_meals_included(provider_param_meals_included) if provider_param_meals_included
      providers = providers.search_by_care_type_ids(provider_param_care_type_ids) if provider_param_care_type_ids
      providers = providers.search_by_zip_code_ids(provider_param_zip_code_ids) if provider_param_zip_code_ids
      providers = providers.search_by_neighborhood_ids(provider_param_neighborhood_ids) if provider_param_neighborhood_ids
      providers = providers.near(provider_param_near_address, 20) if provider_param_near_address
      providers = providers.search_by_days_and_hours(provider_param_open_days) if provider_param_open_days
      providers = providers.search_by_language_ids(provider_param_language_ids) if provider_param_language_ids
      providers = providers.search_by_program_ids(provider_param_program_ids) if provider_param_program_ids
      providers = providers.search_by_subsidy_ids(provider_param_subsidy_ids) if provider_param_subsidy_ids
      # those filters will change when filtering by children will be in place
      providers = providers.search_by_ages(provider_param_ages) if provider_param_ages
      providers = providers.search_by_schedule_year_ids(provider_param_schedule_year_ids) if provider_param_schedule_year_ids
      providers = providers.search_by_schedule_week_ids(provider_param_schedule_week_ids) if provider_param_schedule_week_ids
      providers = providers.search_by_schedule_day_ids(provider_param_schedule_day_ids) if provider_param_schedule_day_ids

      # randomize result order per user unless searching by near by address
      if provider_param_near_address
        # Preload associated provider models where we need information for display in the results list
        # (prevents individual join queries for each provider)
        provider_size = providers.size
        providers = providers.preload(:care_type, :licenses, :schedule_hours, :subsidies)
      else
        Provider.connection.execute "SELECT setseed(#{@current_parent.random_seed})"
        # TODO: write inner join, since eager_load users an outer join and doesn't give all the results
        # providers = providers.eager_load(:care_type, :licenses, :schedule_hours, :subsidies).select(['*', 'random()']).order('random()')
        provider_size = providers.size
        providers = providers.preload(:care_type, :licenses, :schedule_hours, :subsidies).select(['providers.*', 'random()']).group('providers.id').order('random()')
      end

      render json: {
        total: provider_size,
        providers: providers.page(params[:page]).per(params[:per_page]),
      }, status: 200
    end

    def show
      provider = Provider.preload(
        :care_type,
        :languages,
        :licenses,
        :meals,
        :programs,
        :schedule_days,
        :schedule_hours,
        :schedule_weeks,
        :subsidies,
      ).find(params[:id])
      render json: ProviderSerializer.new(provider), status: 200
    end

    private

    def create_referral_log
      if parent_params[:parents_care_reasons_attributes]
        care_reason_ids = parent_params[:parents_care_reasons_attributes].collect{|pcra| pcra["care_reason_id"]}
      else
        care_reason_ids = @current_parent.care_reasons.collect(&:id)
      end

      ReferralLog.create(
        params: params,
        parent: @current_parent,
        child_age_months: provider_param_ages.first,
        schedule_week_ids: provider_param_schedule_week_ids,
        schedule_year_id: provider_param_schedule_year_ids.first,
        care_reason_ids: care_reason_ids
      )
    end

    def provider_params
      params.require(:providers).permit(
        :near_address,
        :co_op,
        :meals_included,
        :potty_training,

        subsidy_ids: [],
        program_ids: [],

        ages: [],
        care_type_ids: [],
        language_ids: [],
        neighborhood_ids: [],
        open_days: [],
        schedule_day_ids: [],
        schedule_week_ids: [],
        schedule_year_ids: [],
        zip_code_ids: [],
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
