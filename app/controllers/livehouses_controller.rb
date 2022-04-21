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
    @q_livehouse = Livehouse.ransack(params[:q])
    @result_livehouses = @q_livehouse.result(distinct: true)
  end
end
