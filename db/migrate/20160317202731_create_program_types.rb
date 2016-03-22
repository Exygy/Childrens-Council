class CreateProgramTypes < ActiveRecord::Migration
  def change
    create_table :program_types do |t|
      t.text :name, null: false
    end
  end
end
