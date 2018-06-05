module Api
  class ProvidersController < ApiController
    before_action :create_referral_log, only: :index

    def index
      render json: NDS.search_providers(search_params), status: 200
    end

    def show
      @provider = nds_provider
      @provider[:images] = provider_images
      render json: @provider, status: 200
    end

    private

    def nds_provider
      NDS.provider_by_id(provider_id)
    end

    def provider_images
      ProviderImageService.get(provider_id)
    end

    def provider_id
      params[:id]
    end

    def create_referral_log
      # if parent_params[:parents_care_reasons_attributes]
      #   care_reason_ids = parent_params[:parents_care_reasons_attributes].collect{|pcra| pcra["care_reason_id"]}
      # else
      #   care_reason_ids = @current_parent.care_reasons.collect(&:id)
      # end

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

    def search_params
      { "locationA": {},
        "locationB": {},
      	"zip": "94114",
      	"attributesLocal17": [],
      	"ageGroupServiced": 13,
      	"ageGroup": nil,
      	"typeOfCare": nil,
      	"yearlySchedule": nil,
      	"weeklySchedule": [],
      	"dailySchedule": {},
      	"weeklyRate": {},
        "monthlyRate": {},
      	"generalLocal2": [],
      	"financialAssist": [],
      	"languages": [],
      	"attributesLocal3": [],
      	"meals": [],
      	"environment": []
      }
    end
  end
end
