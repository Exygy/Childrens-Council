class AddProgramFieldsToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :potty_training, :boolean, default: false
    add_column :providers, :co_op, :boolean, default: false
    add_column :providers, :nutrition_program, :boolean, default: false
  end
end
