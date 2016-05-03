class AddCachedGeocodableAddressStringToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :cached_geocodable_address_string, :string
  end
end
