class CreateCareReasonJoinTable < ActiveRecord::Migration
  def change
    create_join_table :parents, :care_reasons do |t|
      t.index [:parent_id, :care_reason_id]
      t.index [:care_reason_id, :parent_id]
    end
  end
end
