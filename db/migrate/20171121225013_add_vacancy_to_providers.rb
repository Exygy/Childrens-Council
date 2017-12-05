class AddVacancyToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :vacancy, :integer
  end
end
