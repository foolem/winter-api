class Chat < ApplicationRecord
  belongs_to :match, dependent: :destroy
  has_many :messages, dependent: :destroy
end
