class AddAuthToParents < ActiveRecord::Migration
  def change
    change_table :parents do |t|
      t.string :provider, default: 'email'
      t.text :uid, default: ''
      t.text :tokens

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end

    # updates the parent table immediately with the above defaults
    Parent.reset_column_information

    # finds all existing users and updates them.
    # if you change the default values above you'll also have to change them here below:
    Parent.find_each do |parent|
      parent.uid = parent.email
      parent.provider = 'email'
      parent.save(validate: false)
    end

    # to speed up lookups to these columns:
    add_index :parents, [:uid, :provider]
  end
end
