class FavoritesController < ApplicationController
  before_action :set_livehouse, only: %i[create destroy]

  def index
    @favorite_livehouses = current_user.favorite_livehouses
  end

  def show
    @favorite_livehouses = current_user.favorite_livehouses
    @livehouse = Livehouse.find(params[:id])
    @events = @livehouse.events.where('held_on >= ?', Date.current)
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
end
