class CreateNeighborhoodsParentsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :neighborhoods, :parents do |t|
      t.index [:neighborhood_id, :parent_id], unique: true
      t.index [:parent_id, :neighborhood_id]
    end
  end
end
