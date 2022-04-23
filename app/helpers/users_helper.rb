module UsersHelper

  def correct_user?
    return if current_user.id.to_s == params[:id]
    redirect_to root_path, alert:'アクセスできません。'
  end

end
