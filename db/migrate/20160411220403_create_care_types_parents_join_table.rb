class CreateCareTypesParentsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :care_types, :parents do |t|
      t.index [:care_type_id, :parent_id], unique: true
      t.index [:parent_id, :care_type_id]
    end

    add_timestamps :care_types_parents, null: false

    drop_table :care_types_children do |t|
      t.integer :care_type_id, null: false
      t.integer :child_id, null: false
      t.timestamps null: false
      t.index [:care_type_id, :child_id], unique: true
      t.index [:child_id, :care_type_id]
    end
  end
end
