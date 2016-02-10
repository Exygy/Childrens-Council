class CreateCareTypesChildrenJoinTable < ActiveRecord::Migration
  def change
    create_join_table :care_types, :children do |t|
      t.index [:care_type_id, :child_id], unique: true
      t.index [:child_id, :care_type_id]
    end
  end
end
