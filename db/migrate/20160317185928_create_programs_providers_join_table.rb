class CreateProgramsProvidersJoinTable < ActiveRecord::Migration
  def change
    create_join_table :programs, :providers do |t|
      t.index [:program_id, :provider_id]
      t.index [:provider_id, :program_id], unique: true
    end

    add_foreign_key :programs_providers, :programs
    add_foreign_key :programs_providers, :providers
  end
end
