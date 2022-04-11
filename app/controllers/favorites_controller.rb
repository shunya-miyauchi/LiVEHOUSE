class FavoritesController < ApplicationController
  before_action :livehouse_params, only: %i[create destroy]

  def index
    @favorite_livehouses = current_user.favorite_livehouses
  end

  def show
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

  def livehouse_params
    @livehouse = Livehouse.find(params[:id])
  end

end

