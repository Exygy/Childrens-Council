namespace :providers do
  desc 'Update licensed ages'
  task update_ages: :environment do
    Provider.all.each do |provider|
      provider.update_column :licensed_ages, provider.calculate_ages
    end
  end
end
