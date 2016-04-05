class ChangeDefaultDisplayForSubsidies < ActiveRecord::Migration
  def up
    change_column_default :subsidies, :display, false
  end

  def down
    change_column_default :subsidies, :display, nil
  end
end
