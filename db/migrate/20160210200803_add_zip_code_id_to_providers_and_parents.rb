class AddZipCodeIdToProvidersAndParents < ActiveRecord::Migration
  def change
    add_column :providers, :zip_code_id, :integer, index: true
    add_column :providers, :mail_zip_code_id, :integer, index: true
    add_column :parents, :zip_code_id, :integer, index: true
    remove_column :providers, :zip, :text
    remove_column :providers, :mail_zip, :text
    remove_column :parents, :zip, :text
  end
end
