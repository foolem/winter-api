class ChatMessagesSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :chat_id, :content
end
