class UsersController < ApplicationController
  before_action :set_preference, only: [:choose_preference]
  before_action :set_user, only: [:like, :reject]
  before_action :set_chat, only: [:chat_messages]
  before_action :authenticate_user!

  def timeline
    render json: current_user.timeline
  end

  def single_user_timeline
    render json: current_user.single_user_timeline
  end

  def matches
    render json: current_user.matches
  end

  def chat_messages
    render json: @chat.messages
  end

  def preferences
    render json: current_user.preferences
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
    current_user.preferences << @preference
    render json: current_user.preferences
  end

  def top_5
    result = current_user.top_5
    render json: result.to_json
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
