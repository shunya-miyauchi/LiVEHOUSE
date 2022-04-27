class FavoritesController < ApplicationController
  before_action :set_livehouse, only: %i[create destroy]
  before_action :set_livehouses, only: %i[index]
  before_action :q_event, only: %i[index]

  def index
    @livehouses = current_user.favorite_livehouses
    respond_to do |format|
      format.html {}
      format.js { render :schedule }
    end
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

  # 期間検索
  def q_event
    @q_event = Event.where(livehouse_id: @livehouses.ids).ransack(params[:date_search], search_key: :date_search)
    @events =
      if @q_event.conditions.present?
        @q_event.result(distinct: true).sort_held_on.page(params[:page]).per(12)
      else
        Event.where(livehouse_id: @livehouses.ids).date_after_today.sort_held_on.page(params[:page]).per(12)
      end
  end
end
