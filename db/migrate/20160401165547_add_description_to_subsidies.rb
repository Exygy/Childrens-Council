class AddDescriptionToSubsidies < ActiveRecord::Migration
  def change
    add_column :subsidies, :description, :text
  end
end
