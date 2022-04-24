class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :correct_user?
  before_action :set_user
  before_action :q_livehouse
  before_action :q_event

  def show
    respond_to do |format|
      format.html {}
      format.js do
        if params[:q].present?
          render :index
        else
          render :schedule
        end
      end
    end
  end

  def past_joins
    respond_to do |format|
      format.html {}
      format.js do
        if params[:q].present?
          render :index
        else
          render :schedule
        end
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def q_livehouse
    @q_livehouse = Livehouse.ransack(params[:q])
    @result_livehouses = @q_livehouse.result(distinct: true)
  end

  def q_event
    @q_event = @user.join_events.ransack(params[:date_search], search_key: :date_search)
    if @q_event.conditions.present?
      @events_future =
        @q_event.result(distinct: true).date_after_today.sort_held_on.page(params[:page]).per(12)
      @events_past =
        @q_event.result(distinct: true).date_before_today.reverse_held_on.page(params[:page]).per(12)
    else
      @events_future =
        @user.join_events.includes(:livehouse).date_after_today.sort_held_on.page(params[:page]).per(12)
      @events_past =
        @user.join_events.includes(:livehouse).date_before_today.reverse_held_on.page(params[:page]).per(12)
    end
  end
end
