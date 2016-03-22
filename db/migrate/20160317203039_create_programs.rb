class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.text :name, null: false
      t.references :program_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
