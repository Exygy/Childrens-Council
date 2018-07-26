require 'json'
require 'open-uri'
require 'uri'

module NdsProviderService
  class << self
    def get(provider_id)
      @provider_id = provider_id
      @provider = nds_provider
      # @provider[:enrollments] = nds_provider_enrollments
      @provider[:images] = provider_images
      # @provider[:rates] = nds_provider_rates
      @provider[:schedule] = nds_provider_schedule
      @provider
    end

    private

    def nds_provider
      NDS.provider_by_id(provider_id)
    end

    def nds_provider_enrollments
      NDS.provider_enrollments(provider_uid)
    end

    def nds_provider_schedule
      NDS.provider_schedule(provider_uid)
    end

    def nds_provider_rates
      NDS.provider_rates(provider_uid)
    end

    def provider_images
      ProviderImageService.get(provider_id)
    end

    def provider_id
      @provider_id
    end

    def provider_uid
      @provider['providerUID']
    end
  end
end
