class ChangeTypeToLicenseTypeOnLicenseTable < ActiveRecord::Migration
  def change
    rename_column :licenses, :type, :license_type
  end
end
