class CreateCareTypes < ActiveRecord::Migration
  def change
    create_table :care_types do |t|
      t.text :name, null: false
      t.boolean :facility, default: false
    end
  end
end
