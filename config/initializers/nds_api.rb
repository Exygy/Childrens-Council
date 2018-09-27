NDS = NdsApi::Client.new(
  agency_key: ENV['NDS_API_AGENCY_KEY'] || 13_011,
  user: ENV['NDS_API_USERNAME'] || 'exygy',
  password: ENV['NDS_API_PASSWORD'] || 'testnaccrra',
  # password: 'SnowflakeFrog?',
  dev: true
)
