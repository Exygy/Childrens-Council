module Api
  class ProvidersController < ApiController
    before_action :create_referral_log, only: :index

    def index
      provider_size = 40
      providers = [] # NDS.search()

      render json: {
        total: provider_size,
        providers: providers.page(params[:page]).per(params[:per_page]),
      }, status: 200
    end

    def show
      render json: NDS.provider_by_uid(params[:id]), status: 200
    end

    private

    def create_referral_log
      if parent_params[:parents_care_reasons_attributes]
        care_reason_ids = parent_params[:parents_care_reasons_attributes].collect{|pcra| pcra["care_reason_id"]}
      else
        care_reason_ids = @current_parent.care_reasons.collect(&:id)
      end

      # NDS.create_referral(
      #         params: params,
      #         parent: @current_parent,
      #         child_age_months: provider_param_ages.first,
      #         schedule_week_ids: provider_param_schedule_week_ids,
      #         schedule_year_id: provider_param_schedule_year_ids.first,
      #         care_reason_ids: care_reason_ids
      #       )
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
