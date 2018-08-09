# frozen_string_literal: true

NDS_AGENCY_KEY = ENV['NDS_AGENCY_KEY']

NDS = NdsApi::Client.new(
  agency_key: NDS_AGENCY_KEY || 13_011,
  user: 'exygy',
  password: 'testnaccrra',
  # password: 'SnowflakeFrog?',
  dev: true
)
