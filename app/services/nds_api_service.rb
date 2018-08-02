class NdsApiService
  AGENCY_OPTION_TYPE_IDS = {
    neighborhoods: 15
  }

  def fetch_filter_data
    AGENCY_OPTION_TYPE_IDS.each do |type, id|
      raw_option_data = NDS.get_agency_option(id)
      options = raw_option_data.map{ |opt| opt['value'] if opt['value'] }.compact
      File.write("#{Rails.root}/config/filter_data/#{type}.yml", options.to_yaml)
    end
  end
end
