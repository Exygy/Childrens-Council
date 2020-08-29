# == Schema Information
#
# Table name: temp_parents
#
#  id         :integer          not null, primary key
#  email      :string
#  api_key    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TempParent < ActiveRecord::Base
    before_create :set_api_key

    validates :email, uniqueness: { case_sensitive: false }, allow_blank: true

    private

    def set_api_key
        self.api_key = Devise.friendly_token.first(20)
    end
end
