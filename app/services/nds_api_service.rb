class NdsApiService
  AGENCY_OPTIONS = {
    4 => :languages,
    8 => :care_approaches,
    9 => :language_immersion_programs,
    15 => :neighborhoods
  }

  def fetch_filter_data(id)
    id = id.to_i
    raw_option_data = NDS.get_agency_option(id)
    options = raw_option_data.map{ |opt| opt['value'] if opt['value'] }.compact
    type = AGENCY_OPTIONS[id]
    File.write(yaml_file_path(type), options.to_yaml)
  end

  def fetch_all_filter_data
    self.class::AGENCY_OPTIONS.each { |id, type| fetch_filter_data(id) }
  end

  def filter_data(type)
    YAML.load_file(yaml_file_path(type))
  end

  def fetch_all_provider_ids
    provider_ids = [] 
    number_of_pages = NDS.search_providers({}, page: 0, size: 30 )[:totalPages]
    number_of_pages.times do |page_number|  
        NDS.search_providers({}, page: page_number, size: 30 )[:content].each do |provider|
            provider_ids << provider['providerId']
        end
    end
    provider_ids.uniq
  end

  private

  def yaml_file_path(type)
    "#{Rails.root}/config/filter_data/#{type}.yml"
  end
end