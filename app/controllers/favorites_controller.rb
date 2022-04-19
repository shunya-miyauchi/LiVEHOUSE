class FavoritesController < ApplicationController
  before_action :set_livehouse, only: %i[create destroy]

  def index
    @livehouses = current_user.favorite_livehouses
    @events = Event.where(livehouse_id: @livehouses.ids).date_after_today.sort_held_on.page(params[:page]).per(12)
    return unless request.xhr?
    render :schedule
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
