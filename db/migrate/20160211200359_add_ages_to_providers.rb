class AddAgesToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :ages, :integer, array:true, default: []
  end
end
