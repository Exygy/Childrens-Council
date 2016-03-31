class AddSubscribeToParent < ActiveRecord::Migration
  def change
    add_column :parents, :subscribe, :boolean
  end
end
