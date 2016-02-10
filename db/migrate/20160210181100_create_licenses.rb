class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.integer :provider_id, index: true, null: false
      t.date :date
      t.boolean :exempt
      t.integer :type
      t.text :number
      t.integer :capacity
      t.integer :capacity_desired
      t.integer :capacity_subsidy
      t.integer :age_from_year
      t.integer :age_from_month
      t.integer :age_to_year
      t.integer :age_to_month
      t.integer :vacancies
      t.timestamps null: false
    end
  end
end
