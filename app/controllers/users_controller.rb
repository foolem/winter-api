class UsersController < ApplicationController
  before_action :authenticate_user!

  def timeline
    render json: current_user.timeline
  end

  def matches
    render json: current_user.matches
  end
end
