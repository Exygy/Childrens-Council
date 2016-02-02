class AddPhoneToParents < ActiveRecord::Migration
  def change
    add_column :parents, :phone, :string, limit: 10
  end
end
