class AddDisplayToSubsidies < ActiveRecord::Migration
  def change
    add_column :subsidies, :display, :boolean
  end
end
