require 'json'
require 'open-uri'
require 'uri'

module ProviderImageService
  class << self
    def get(provider_ids)
      @provider_ids = provider_ids
      http_get(provider_image_url)
    end

    private

    def http_get(url)
      JSON.parse(open(url).read)
    rescue => e
      puts e.inspect
      return {}
    end

    def provider_image_url
      "#{wordpress_url}?#{query_params}"
    end

    def query_params
      multiple_provder_ids ? query_params_as_array : query_params_as_int
    end

    def query_params_as_int
      "#{param}=#{@provider_ids}"
    end

    def query_params_as_array
      @provider_ids.collect{ |id| "#{param}[]=#{id}" }.join('&')
    end

    def multiple_provder_ids
      @provider_ids.kind_of?(Array)
    end

    def param
      "get_provider_image_urls"
    end

    def wordpress_url
      # ENV['WORDPRESS_URL'] || 
      'http://www.childrenscouncil.org/'
    end
  end
end
