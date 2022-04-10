class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    if current_user.id.to_s == params[:id]
      @user = User.find(params[:id])
    else
      redirect_to root_path
    end
  end
end
