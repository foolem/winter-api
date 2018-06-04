class MatchSerializer < ActiveModel::Serializer
  attributes :id, :first_user_id, :second_user_id, :first_like, :second_like, :chat_id
end
