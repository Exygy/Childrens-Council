class AddIndexesToForeignKeys < ActiveRecord::Migration
  def change
    add_index :providers, :city_id
    add_index :providers, :state_id
    add_index :providers, :zip_code_id
    add_index :providers, :mail_city_id
    add_index :providers, :mail_state_id
    add_index :providers, :mail_zip_code_id
    add_index :providers, :schedule_year_id
    add_index :parents, :zip_code_id
    add_index :children, :schedule_year_id
  end
end
