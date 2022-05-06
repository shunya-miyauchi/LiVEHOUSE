class EventsController < ApplicationController
  before_action :set_livehouse
  before_action :q_livehouse
  before_action :q_event

  def index
    respond_to do |format|
      format.html {}
      format.js do
        if params[:page]
          render :schedule
        elsif params[:livehouse_search]
          render :index
        end
      end
    end
  end

  def show
    @event = Event.includes(:livehouse).find(params[:id])
    @comments = @event.comments.includes(:user).reverse_created_at
    @comment = Comment.new
  end

  private

  def set_livehouse
    @livehouse = Livehouse.find(params[:livehouse_id])
  end

  # ライブハウス検索
  def q_livehouse
    @q_livehouse = Livehouse.ransack(params[:livehouse_search], search_key: :livehouse_search)
    @livehouses =
      if @q_livehouse.conditions.present?
        @q_livehouse.result(distinct: true)
      else
        Livehouse.where(place_id: @livehouse.place_id)
      end
  end

  # 期間検索
  def q_event
    @q_event = @livehouse.events.ransack(params[:date_search], search_key: :date_search)
    @events =
      if @q_event.conditions.present?
        @q_event.result(distinct: true).sort_held_on.page(params[:page]).per(12)
      else
        @livehouse.events.date_after_today.sort_held_on.page(params[:page]).per(12)
      end
  end
end
