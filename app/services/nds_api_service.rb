class NdsApiService
  AGENCY_OPTION_TYPE_IDS = {
    care_approaches: 8,
    neighborhoods: 15
  }

  def fetch_all_filter_data
    AGENCY_OPTION_TYPE_IDS.each do |type, id|
      raw_option_data = NDS.get_agency_option(id)
      options = raw_option_data.map{ |opt| opt['value'] if opt['value'] }.compact
      File.write(yaml_file_path(type), options.to_yaml)
    end
  end

  def filter_data(type)
    YAML.load_file(yaml_file_path(type))
  end

  private

  def yaml_file_path(type)
    "#{Rails.root}/config/filter_data/#{type}.yml"
  end
end
