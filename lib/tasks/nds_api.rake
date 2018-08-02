namespace :nds_api do
  desc "Fetch the Children's Council-specific filter data from the NDS API and store in YAML"
  task fetch_filter_data: :environment do
    NdsApiService.new.fetch_filter_data()
  end
end
