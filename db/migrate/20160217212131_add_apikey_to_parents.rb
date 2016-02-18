class AddApikeyToParents < ActiveRecord::Migration
  def change
    add_column :parents, :api_key, :string
  end
end
