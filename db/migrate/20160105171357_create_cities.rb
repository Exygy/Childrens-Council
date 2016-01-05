class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.text :name, null: false
    end
  end
end
