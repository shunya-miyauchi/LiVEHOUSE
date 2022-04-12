class JoinsController < ApplicationController
  before_action :event_params
  
  def create
    current_user.joins.create(event_id: params[:id])
  end

  def destroy
    current_user.joins.find_by(event_id: params[:id]).destroy
  end

  private

  def event_params
    @event = Event.find(params[:id])
  end
end
