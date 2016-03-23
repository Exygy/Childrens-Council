class ChangeAgeMonthToAgeMonthsOnChild < ActiveRecord::Migration
  def change
	   rename_column :children, :age_month, :age_months
     remove_column :children, :age_year
  end
end
