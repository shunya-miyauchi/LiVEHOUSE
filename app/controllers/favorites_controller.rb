class FavoritesController < ApplicationController
  before_action :set_livehouse, only: %i[show create destroy]
  before_action :set_livehouses, only: %i[index show]

  def index
    @events = Event.where(livehouse_id: @livehouses.ids).date_after_today.sort_held_on
  end

  def show
    @events = @livehouse.events.date_after_today
  end

  def create
    current_user.favorites.create(livehouse_id: params[:id])
  end

  def destroy
    current_user.favorites.find_by(livehouse_id: params[:id]).destroy
  end

  private

  def set_livehouse
    @livehouse = Livehouse.find(params[:id])
  end

  def set_livehouses
    @livehouses = current_user.favorite_livehouses
  end
end
