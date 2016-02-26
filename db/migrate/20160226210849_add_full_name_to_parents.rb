class AddFullNameToParents < ActiveRecord::Migration
  def change
    add_column :parents, :full_name, :string
  end
end
