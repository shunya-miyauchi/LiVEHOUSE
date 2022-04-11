class CommentsController < ApplicationController
  def create
    @livehouse = Livehouse.find(params[:livehouse_id])
    @event = Event.find(params[:event_id])
    @comment = @event.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
