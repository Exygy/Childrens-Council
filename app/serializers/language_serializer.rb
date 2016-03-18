# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name
end
