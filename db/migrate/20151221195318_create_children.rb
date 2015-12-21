class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.integer :age, null: false
      t.string :zip

      t.timestamps null: false
    end
  end
end
