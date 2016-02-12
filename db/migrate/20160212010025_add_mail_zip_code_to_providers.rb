class AddMailZipCodeToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :mail_zip_code, :string
    remove_column :providers, :mail_zip_code_id, :integer
  end
end
