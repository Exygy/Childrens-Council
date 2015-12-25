class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.text :first_name, null: false
      t.text :last_name, null: false
      t.citext :email
      t.timestamps null: false
    end
  end
end
