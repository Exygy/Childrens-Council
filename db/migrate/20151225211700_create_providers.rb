class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.text :name, null: false
      t.text :alternate_name
      t.text :contact_name
      t.text :phone
      t.text :phone_ext
      t.text :phone_other
      t.text :phone_other_ext
      t.text :fax
      t.text :email
      t.text :url
      t.text :address_1
      t.text :address_2
      t.text :zip
      t.text :cross_street_1
      t.text :cross_street_2
      t.text :mail_address_1
      t.text :mail_address_2
      t.text :mail_zip
      t.text :ssn
      t.text :tax_id
      t.timestamps null: false
    end
  end
end
