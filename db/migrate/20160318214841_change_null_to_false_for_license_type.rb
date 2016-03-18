class ChangeNullToFalseForLicenseType < ActiveRecord::Migration
  def change
    change_column_null :licenses, :license_type, false
  end
end
