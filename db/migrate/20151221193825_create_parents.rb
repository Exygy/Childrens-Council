class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :email, null: false, uniqueness: true
      t.index :email, unique: true
      t.string :first_name
      t.string :last_name
      t.timestamps null: false
    end
  end
end
