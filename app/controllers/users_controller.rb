class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :correct_user?
  before_action :set_user

  def show
    @events = @user.join_events.date_after_today.sort_held_on
  end

  def past_joins
    @events = @user.join_events.date_before_today.reverse_held_on
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user?
    current_user.id.to_s == params[:id]
  end
end
