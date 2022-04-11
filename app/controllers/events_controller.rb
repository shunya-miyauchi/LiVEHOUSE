class EventsController < ApplicationController
  def index
    @livehouses = Livehouse.all
    @livehouse = Livehouse.find(params[:livehouse_id])
    @events = @livehouse.events.where('held_on >= ?', Date.current)
  end

  def show
    @livehouses = Livehouse.all
    @livehouse = Livehouse.find(params[:livehouse_id])
    @event = Event.find(params[:id])
    @comments = @event.comments
    @comment = Comment.new
  end
end
