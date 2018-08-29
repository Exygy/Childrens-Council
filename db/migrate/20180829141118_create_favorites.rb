class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :parent_id
      t.string :provider_uid

      t.timestamps null: false
    end

    add_foreign_key :favorites, :parents, on_delete: :cascade
    add_index :favorites, [:parent_id, :provider_uid], unique: true
  end
end
