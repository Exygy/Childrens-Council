class CreateCareReasons < ActiveRecord::Migration
  def change
    create_table :care_reasons do |t|
      t.text :name, null: false
    end
  end
end
