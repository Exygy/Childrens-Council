class AddLanguageColumnsToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :english_capability, :integer
    add_column :providers, :preferred_language_id, :integer
    add_index :providers, :preferred_language_id
    add_foreign_key :providers, :languages, column: :preferred_language_id
  end
end
