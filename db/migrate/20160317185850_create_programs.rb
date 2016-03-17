class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.text :name, null: false
    end
  end
end
