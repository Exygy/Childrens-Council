class CreateFoundOptions < ActiveRecord::Migration
  def change
    create_table :found_options do |t|
      t.text :name, null: false
    end
  end
end
