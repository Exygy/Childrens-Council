namespace :providers do
  desc 'Update licensed ages and lat&lng'
  task update_ages_and_geolocation: :environment do
    Provider.all.each do |provider|
      should_update = (!provider.geocoded? or provider.cached_geocodable_address_string != provider.geocodable_address_string or provider.licensed_ages != provider.calculate_ages)
      if should_update
        provider.save
        sleep 6
      end
    end
  end
end
