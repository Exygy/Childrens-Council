class CreateTempParents < ActiveRecord::Migration
  def change
    create_table :temp_parents do |t|
      t.string :email
      t.string :api_key

      t.timestamps null: false
    end
  end
end
