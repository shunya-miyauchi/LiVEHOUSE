class EventsController < ApplicationController
  before_action :set_event
  before_action :q_livehouse
  before_action :q_event

  def index
    @events = @livehouse.events.date_after_today.sort_held_on
  end

  def show
    @event = Event.find(params[:id])
    @comments = @event.comments
    @comment = Comment.new
  end

  private

  def set_event
    @livehouse = Livehouse.find(params[:livehouse_id])
  end

  def q_livehouse
    @q_livehouse = Livehouse.ransack(params[:q])
    @result_livehouses =
      if @q_livehouse.conditions.present?
        @q_livehouse.result(distinct: true)
      else
        Livehouse.where(place_id: @livehouse.place_id)
      end
  end

  def q_event
    @q_event = Event.ransack(params[:date_search], search_key: :date_search)
    @result_events =
      if @q_event.conditions.present?
        @q_event.result(distinct: true).sort_held_on
      else
        @livehouse.events.date_after_today.sort_held_on
      end
  end
end
