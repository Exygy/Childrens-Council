class AddFoundOptionIdToParents < ActiveRecord::Migration
  def change
    add_reference :parents, :found_option, index: true
  end
end
