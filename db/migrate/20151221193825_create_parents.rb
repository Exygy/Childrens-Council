class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email
      t.timestamps null: false
    end
  end
end
