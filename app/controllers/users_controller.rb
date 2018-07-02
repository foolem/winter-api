class UsersController < ApplicationController
  before_action :set_preference, only: :choose_preference
  before_action :set_user, only: [:like, :reject]
  before_action :set_chat, only: :chat_messages
  before_action :authenticate_user!
  before_action :set_current_user, only: :matches

  def timeline
    render json: current_user.timeline, each_serializer: UserSerializer
  end

  def single_user_timeline
    render json: current_user.single_user_timeline, each_serializer: UserSerializer
  end

  def matches
    render json: current_user.matches, each_serializer: UserMatchSerializer
  end

  def chat_messages
    render json: @chat.messages, each_serializer: MessageSerializer
  end

  def preferences
    render json: current_user.preferences, each_serializer: PreferenceSerializer
  end

  def like
    result = current_user.like(@user)
    render json: result, serializer: MatchSerializer
  end

  def reject
    result = current_user.reject(@user)
    render json: result, serializer: MatchSerializer
  end

  def choose_preference
    current_user.preferences << @preference if !(current_user.preferences.include?(@preference))
    render json: current_user.preferences, each_serializer: PreferenceSerializer
  end

  def top_5
    render json: current_user.top_5, each_serializer: UserSerializer
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
    if !(Match.where(id: params[:match_id]).blank?)
      @chat = Match.where(id: params[:match_id]).first.chat
    else
      render json: "Chat não encontrado".to_json , status: :not_found
    end
  end

end
