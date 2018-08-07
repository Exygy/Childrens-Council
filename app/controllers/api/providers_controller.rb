module Api
  class ProvidersController < ApiController
    before_action :create_referral_log, only: :index

    def index
      results = search_providers_with_images(params[:providers])
      render json: results, status: 200
    end

    def show
      provider = nds_provider
      provider[:images] = provider_images if provider
      render json: provider, status: provider ? 200 : 404
    end

    private

    # index

    def search_providers_with_images(search_params)
      @results = NDS.search_providers(search_params) #, page: X

      @results[:content].each do |provider_data|
        provider_data[:images] = providers_images[provider_data["providerId"].to_s]
      end if @results[:content]

      @results
    end

    def meta_data(age_group_type_id)
      return @meta_data[age_group_type_id] if @meta_data and @meta_data[age_group_type_id]
      @meta_data ||= {}
      @meta_data[age_group_type_id] = NDS.get_agency_option(age_group_type_id).first["value"]
    end

    def providers_images
      @providers_images ||= ProviderImageService.get(provider_ids)
    end

    def provider_ids
      @results[:content].collect{ |provider_data| provider_data["providerId"] }
    end

    # show

    def nds_provider
      begin
        NDS.provider_by_id(provider_id)
      rescue OpenURI::HTTPError
        false
      end
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
        # :co_op,
        # schedule_week_ids: [],
        :ageGroupServiced,
        :locationA,
        :typeOfCare,
        :yearlySchedule,
        :zip,
        attributesLocal17: [],
        attributesLocal3: [],
        environments: [],
        financialAssist: [],
        generalLocal2: [],
        languages: [],
        meals: [],
        weeklySchedule: [],
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
      	"zip": nil,
      	"attributesLocal17": [],
      	"ageGroupServiced": nil,
      	"ageGroup": nil,
      	"typeOfCare": nil,
      	"yearlySchedule": nil,
      	"weeklySchedule": [],
      	"dailySchedule": {},
      	"weeklyRate": {},
        "monthlyRate": {},
      	"generalLocal2": [],
      	"financialAssist": [],

        "languages": ["Khmu"],
	      "attributesLocal3": [],

      	"attributesLocal3": [],
      	"meals": [],
      	"environment": []
      }
    end
  end
end
