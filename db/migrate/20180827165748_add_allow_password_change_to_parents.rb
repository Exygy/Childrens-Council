class AddAllowPasswordChangeToParents < ActiveRecord::Migration
  def change
    add_column :parents, :allow_password_change, :boolean, default: false, null: false
  end
end
