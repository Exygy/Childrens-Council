class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.text :name
      t.text :abbr
    end
  end
end
