class AddDefaultsToBooleanColumns < ActiveRecord::Migration
  def up
    change_column_default :schedule_hours, :closed, false
    change_column_default :licenses, :exempt, false
    change_column_default :providers, :accepting_referrals, true
  end

  def down
    change_column_default :schedule_hours, :closed, nil
    change_column_default :licenses, :exempt, nil
    change_column_default :providers, :accepting_referrals, nil
  end
end
