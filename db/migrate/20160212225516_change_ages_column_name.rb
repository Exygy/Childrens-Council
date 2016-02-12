class ChangeAgesColumnName < ActiveRecord::Migration
  def change
    rename_column :providers, :ages, :licensed_ages
  end
end
