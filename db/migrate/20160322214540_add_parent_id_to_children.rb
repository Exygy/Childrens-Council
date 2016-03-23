class AddParentIdToChildren < ActiveRecord::Migration
  def change
    add_reference :children, :parent, index: true, foreign_key: true
  end
end
