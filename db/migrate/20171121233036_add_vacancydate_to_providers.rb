class AddVacancydateToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :vacancydate, :date
  end
end
