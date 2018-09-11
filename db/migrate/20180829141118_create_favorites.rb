class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :parent_id
      t.integer :provider_id

      t.timestamps null: false
    end

    add_foreign_key :favorites, :parents, on_delete: :cascade
    add_index :favorites, [:parent_id, :provider_id], unique: true
  end
end
