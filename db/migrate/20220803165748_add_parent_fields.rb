class AddParentFields < ActiveRecord::Migration
  def change
    add_column :parents, :care_reason, :text
    add_column :parents, :found_option, :text
  end
end
