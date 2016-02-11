class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.text :name, null: false
    end
  end

  add_reference :providers, :neighborhood, index: true
end
