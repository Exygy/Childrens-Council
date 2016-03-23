class AddNearAddressToParent < ActiveRecord::Migration
  def change
    add_column :parents, :near_address, :string
  end
end
