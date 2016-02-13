class CreateLanguageProviders < ActiveRecord::Migration
  def change
    create_table :language_providers do |t|
      t.references :language
      t.references :provider, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
