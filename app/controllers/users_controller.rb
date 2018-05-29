class UsersController < ApplicationController
  before_action :authenticate_user!

  def timeline
    render json: current_user.timeline
  end

  def matches
    render json: current_user.matches
  end

  def preferences
    render json: current_user.preferences
  end

  def like
    result = current_user.like(params[:id].to_i)
    render json: result
  end

  def reject
    current_user.reject(params[:id].to_i)
    render json: :success
  end
end
