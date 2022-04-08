class LivehousesController < ApplicationController
  def index
    @livehouses = Livehouse.where('address LIKE?', '%東京都%')
    @events_this = Event.where('held_on >= ? and held_on <= ?', Date.current, Date.current.end_of_week).sort_by do |a| a[:held_on]
    end
    @events_next = Event.where('held_on >= ? and held_on <= ?', Date.current.next_week(:monday), Date.current.next_week(:sunday)).sort_by do |a| a[:held_on]
    end
  end
end
