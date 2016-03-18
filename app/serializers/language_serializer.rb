# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LanguageSerializer < ActiveModel::Serializer
  attributes :id, :name
end
