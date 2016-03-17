class CreateSubsidies < ActiveRecord::Migration
  def change
    create_table :subsidies do |t|
      t.text :name, null: false
    end
  end
end
