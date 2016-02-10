class AddAgeToChildren < ActiveRecord::Migration
  def change
    remove_column :children, :age
    remove_column :children, :zip
    add_column :children, :age_year, :integer, limit: 2, null: false
    add_column :children, :age_month, :integer, limit: 2, null: false
  end
end
