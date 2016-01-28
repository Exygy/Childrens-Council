# == Schema Information
#
# Table name: providers
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  alternate_name  :text
#  contact_name    :text
#  phone           :text
#  phone_ext       :text
#  phone_other     :text
#  phone_other_ext :text
#  fax             :text
#  email           :text
#  url             :text
#  address_1       :text
#  address_2       :text
#  city_id         :integer
#  state_id        :integer
#  zip             :text
#  cross_street_1  :text
#  cross_street_2  :text
#  mail_address_1  :text
#  mail_address_2  :text
#  mail_city_id    :integer
#  mail_state_id   :integer
#  mail_zip        :text
#  ssn             :text
#  tax_id          :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Provider < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :city
  belongs_to :mail_city, class_name: 'City', foreign_key: :mail_city_id
  belongs_to :state
  belongs_to :mail_state, class_name: 'State', foreign_key: :mail_state_id


  
end
