class AddChatToMatch < ActiveRecord::Migration[5.1]
  def change
    add_reference :matches, :chat, foreign_key: true
  end
end
