class EventsController < ApplicationController

  def index
    @livehouses = Livehouse.all
    @livehouse = Livehouse.find(params[:livehouse_id])
    @events = @livehouse.events
  end

  def show
    @livehouses = Livehouse.all
    @livehouse = Livehouse.find(params[:livehouse_id])
    @event = Event.find(params[:id])
  end
end
