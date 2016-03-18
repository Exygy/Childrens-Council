class UpdateLanguages < ActiveRecord::Migration
  def change
    change_column_null :languages, :name, false

    rename_table :language_providers, :languages_providers
    remove_column :languages_providers, :level, :string
    change_column_null :languages_providers, :language_id, false
    change_column_null :languages_providers, :provider_id, false
    add_foreign_key :languages_providers, :languages
    remove_index :languages_providers, column: :provider_id
    add_index :languages_providers, [:provider_id, :language_id], unique: true
    add_index :languages_providers, [:language_id, :provider_id]
  end
end
