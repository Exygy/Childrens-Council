class CreateParentsZipCodeJoinTable < ActiveRecord::Migration
  def change
    create_join_table :parents, :zip_codes do |t|
      t.index [:parent_id, :zip_code_id]
      t.index [:zip_code_id, :parent_id], unique: true
    end

    remove_column :parents, :zip_code_id, :integer
    add_column :parents, :address, :text
    add_column :parents, :home_zip_code, :string, limit: 5
  end
end
