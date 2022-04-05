class EventsController < ApplicationController

  def index
    @livehouses = Livehouse.all
    @livehouse = Livehouse.find(params[:livehouse_id])
    @events = @livehouse.events
  end
end
