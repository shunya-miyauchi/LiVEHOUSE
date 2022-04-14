class EventsController < ApplicationController
  before_action :set_event
  before_action :q_livehouse
  before_action :q_event

  def index
    @events = @livehouse.events.where('held_on >= ?', Date.current).order(held_on: "ASC")
  end

  def show
    @livehouses = Livehouse.all
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
    if @q_livehouse.conditions.present?
      @result_livehouses = @q_livehouse.result(distinct: true)
    else
      @result_livehouses = Livehouse.where(place_id: @livehouse.place_id)
    end
  end

  def q_event
    @q_event = Event.ransack(params[:date_search], search_key: :date_search)
    if @q_event.conditions.present?
      @result_events = @q_event.result(distinct: true).order(held_on: "ASC")
    else
      @result_events = @livehouse.events.where('held_on >= ?', Date.current).order(held_on: "ASC")
    end
  end
end
