class FavoritesController < ApplicationController
  before_action :livehouse_params

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

