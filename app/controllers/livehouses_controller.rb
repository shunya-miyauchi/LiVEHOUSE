class LivehousesController < ApplicationController
  before_action :q_livehouse

  def index
    render :index unless params[:q].blank?
  end

  private

  def q_livehouse
    @q_livehouse = Livehouse.ransack(params[:q])
    @result_livehouses = @q_livehouse.result(distinct: true)
  end
end
