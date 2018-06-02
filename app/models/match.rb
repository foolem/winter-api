class Match < ApplicationRecord
  belongs_to :first_user, :class_name => 'User'
  belongs_to :second_user, :class_name => 'User'
  belongs_to :chat, optional: true, dependent: :destroy

  def match?
    ((self.first_like.blank? || self.first_like == false) || (self.second_like.blank? || self.second_like == false)) ? false : true
  end

  def create_chat
    match? ? self.update(chat: Chat.create!(match: self)) : false
  end

  def matched_user_name
    self.first_user != User.current ? self.first_user.name : self.second_user.name
  end

end
