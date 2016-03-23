class AddRandomSeedToParents < ActiveRecord::Migration
  def change
    add_column :parents, :random_seed, :float
  end
end
