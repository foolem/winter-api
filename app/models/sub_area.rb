class SubArea < ApplicationRecord
  belongs_to :area
  belongs_to :sub_area, optional: true
  has_many :sub_area_childs, :class_name => 'SubArea'
  has_many :preferences
end
