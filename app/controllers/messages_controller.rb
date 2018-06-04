class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /messages
  def index
    @messages = Message.all

    render json: @messages, each_serializer: MessageSerializer
  end

  # GET /messages/1
  def show
    render json: @message, serializer: MessageSerializer
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created, serializer: MessageSerializer
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message, serializer: MessageSeralizer
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id].to_i)
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:user_id, :chat_id, :content)
    end
end
