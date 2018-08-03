namespace :nds_api do
  desc "Fetch all the Children's Council-specific filter data from the NDS API and store in YAML"
  task fetch_all_filter_data: :environment do
    NdsApiService.new.fetch_all_filter_data()
  end

  desc "Fetch a single Children's Council-specific filter data from the NDS API and store in YAML"
  task :fetch_filter_data, [:id] => [:environment] do |task, args|
    NdsApiService.new.fetch_filter_data(args[:id])
  end

  desc "Fetch a single Children's Council-specific filter data from the NDS API and store in YAML"
  task aggregate_all_filter_data: :environment do |task, args|
    nn = NdsApiAggregatorService.new
    nn.fetch_all_filter_data()
  end
end
