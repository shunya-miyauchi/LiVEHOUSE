class LivehousesController < ApplicationController
  before_action :q_livehouse

  def index
    respond_to do |format|
      format.html {}
      format.js { render :index }
    end
  end

  private

  def q_livehouse
    @q_livehouse = Livehouse.ransack(params[:livehouse_search], search_key: :livehouse_search)
    @livehouses = @q_livehouse.result(distinct: true)
  end
end
