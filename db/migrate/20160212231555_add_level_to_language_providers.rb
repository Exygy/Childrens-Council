class AddLevelToLanguageProviders < ActiveRecord::Migration
  def change
    add_column :language_providers, :level, :string
  end
end
