class AddLatitudeAndLongitudeToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :latitude, :float
    add_column :providers, :longitude, :float
  end
end
