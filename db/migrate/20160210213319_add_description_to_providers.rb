class AddDescriptionToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :description, :text
  end
end
