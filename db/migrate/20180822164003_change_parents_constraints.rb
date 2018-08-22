class ChangeParentsConstraints < ActiveRecord::Migration
  def change
    change_column :parents, :first_name, :text, null: true
    change_column :parents, :last_name, :text, null: true
  end
end
