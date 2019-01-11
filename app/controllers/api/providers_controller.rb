module Api
  class ProvidersController < ApiController
    include CollectReferrals

    def index
      results = search_providers_with_images(provider_params, params[:page])
      render json: results, status: 200
    end

    def show
      provider = nds_provider
      if provider
        provider[:images] = provider_images unless Rails.env.development?
        provider[:favorite] = @resource.favorites.find_by_provider_id(params[:id]).present? if @resource
      end
      render json: provider ? provider : {not_found: true}, status: provider ? 200 : 404
    end

    def bulk_fetch
      results = search_providers_bulk(params[:provider_ids])
      render json: results, status: 200
    end

    private

    # index

    def search_providers_with_images(search_params, page = 0, size = 15)
      begin
        @results = NDS.search_providers(search_params, page: page || 0, size: size )
      rescue
        @results = {}
      end

      add_provider_images_and_favorites(@results[:content])

      @results
    end

    # show

    def nds_provider
      begin
        NDS.provider_by_id(provider_id)
      rescue
        false
      end
    end

    # bulk_fetch

    def search_providers_bulk(provider_ids)
      begin
        @results = NDS.search_providers_bulk(providerIds: provider_ids)
      rescue
        @results = {}
      end

      add_provider_images_and_favorites(@results[:content])

      @results
    end

    # general

    def provider_id
      params[:id]
    end

    def provider_ids
      @results[:content].collect{ |provider_data| provider_data['providerId'] }
    end

    def provider_images
      ProviderImageService.get(provider_id)
    end

    def providers_images
      @providers_images ||= ProviderImageService.get(provider_ids)
    end

    def add_provider_images_and_favorites(providers)
      favorites = @resource.present? ? @resource.favorites : []

      providers.each do |provider|
        provider[:images] = providers_images[provider['providerId'].to_s] unless Rails.env.development?
        provider[:favorite] = favorites.any?{ |f| f.provider_id == provider['providerId'] }
      end if providers
    end

    def provider_params
      params.require(:providers).permit(
        :acceptsDropIns,
        :acceptsChildren,
        :afterSchool,
        :beforeSchool,
        :open24Hours,
        :rotating,
        :ageGroup,
        :agesServiced,
        :distance,
        :yearlySchedule,
        acceptsChildren: [],
        ageGroups: [],
        attributesLocal17: [],
        attributesLocal3: [],
        environment: [],
        generalLocal1: [],
        generalLocal2: [],
        languages: [],
        meals: [],
        monthlyRate: [
          :from,
          :to
        ],
        shiftLocal1: [],
        typesOfCare: [],
        vacancyDateRange: [
          :from,
          :to
        ],
        weeklySchedule: [],
        zips: []
      ).tap do |whitelisted|
        whitelisted[:locationA] = params[:providers][:locationA]
        whitelisted[:attributesLocal3] = params[:providers][:attributesLocal3]
      end
    end
  end
end
