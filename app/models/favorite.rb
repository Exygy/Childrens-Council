# == Schema Information
#
# Table name: favorites
#
#  id          :integer          not null, primary key
#  parent_id   :integer
#  provider_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_favorites_on_parent_id_and_provider_id  (parent_id,provider_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => parents.id) ON DELETE => cascade
#

class Favorite < ActiveRecord::Base
  belongs_to :parent

  validates :provider_id, presence: true, uniqueness: {scope: :parent_id}
  validates :parent_id, presence: true
end
