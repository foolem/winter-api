class UsersController < ApplicationController
  before_action :set_preference, only: :choose_preference
  before_action :set_user, only: [:like, :reject]
  before_action :set_chat, only: :chat_messages
  before_action :authenticate_user!
  before_action :set_current_user, only: :matches

  def timeline
    render json: current_user.timeline
  end

  def single_user_timeline
    render json: current_user.single_user_timeline
  end

  def matches
    render json: current_user.matches, each_serializer: UserMatchesSerializer
  end

  def chat_messages
    render json: @chat.messages, each_serializer: ChatMessagesSerializer
  end

  def preferences
    render json: current_user.user_preferences, each_serializer: UserPreferencesSerializer
  end

  def like
    result = current_user.like(@user)
    render json: result
  end

  def reject
    current_user.reject(@user)
    render json: :success
  end

  def choose_preference
    current_user.preferences << @preference if !(current_user.preferences.include?(@preference))
    render json: current_user.user_preferences, each_serializer: UserPreferencesSerializer
  end

  def top_5
    render json: current_user.top_5
  end

  def destroy
    current_user.destroy
    render json: :success
  end

  private

  def set_preference
    @preference = Preference.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

end
