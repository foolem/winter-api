class Preference < ApplicationRecord
  belongs_to :sub_area
  belongs_to :creator, :class_name => 'User', optional: true
  has_many :user_preferences
  has_many :users, through: :user_preferences
end
