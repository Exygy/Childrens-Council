class AddCareTypeIdToProviders < ActiveRecord::Migration
  def change
    add_reference :providers, :care_type, index: true
  end
end
