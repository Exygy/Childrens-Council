class ChangeParentsConstraints < ActiveRecord::Migration
  def up
    change_column :parents, :first_name, :text, null: true
    change_column :parents, :last_name, :text, null: true
  end

  def down
    change_column :parents, :first_name, :text, null: false
    change_column :parents, :last_name, :text, null: false
  end
end
