class NdsApiAggregatorService < NdsApiService
  AGENCY_OPTIONS = {
    102 => :infant_1_age_group,
    103	=> :infant_2_age_group,
    104	=> :toddler_1_age_group,
    105	=> :toddler_2_age_group,
    106	=> :preschool_1_age_group,
    107	=> :preschool_2_age_group,
    108	=> :school_age_1_group,
    109	=> :school_age_2_group
  }

  def fetch_filter_data(id)
    id = id.to_i
    raw_option_data = NDS.get_agency_option(id)
    options = (filter_data(type) || {}).merge({id => raw_option_data[0]})
    File.write(yaml_file_path(type), options.to_yaml)
  end

  private

  def type
    'age_group_types'
  end
end


