module Api
  class ProvidersController < ApiController
    include CollectReferrals

    def index
      results = search_providers_with_images(provider_params, params[:page])
      render json: results, status: 200
    end

    def show
      provider = nds_provider
      provider[:images] = provider_images if provider
      render json: provider ? provider : {not_found: true}, status: provider ? 200 : 404
    end

    private

    # index

    def search_providers_with_images(search_params, page = 0)
      @results = NDS.search_providers(search_params, page: page)

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
      rescue
        false
      end
    end

    def provider_images
      ProviderImageService.get(provider_id)
    end

    def provider_id
      params[:id]
    end

    def provider_params
      params.require(:providers).permit(
        :age,
        :ageGroup,
        :ageGroupServiced,
        :distance,
        :locationA,
        :yearlySchedule,
        attributesLocal17: [],
        attributesLocal3: [],
        environments: [],
        generalLocal1: [],
        generalLocal2: [],
        languages: [],
        meals: [],
        monthlyRate: [
          :from,
          :to
        ],
        typeOfCare: [],
        weeklySchedule: [],
        zip: [],
      )
    end
  end
end
