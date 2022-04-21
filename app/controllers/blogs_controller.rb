class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update destroy]
  before_action :q_livehouse

  def index
    @blogs = Blog.includes(:event).reverse_created_at.page(params[:page]).per(5)
    respond_to do |format|
      format.html {  }
      format.js {render :schedule }
    end
  end

  def new
    @blog = Blog.new
    @events = current_user.join_events.date_before_today
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to user_path(current_user),notice:"ブログ投稿"
    else
      flash.now[:alert] = '保存できません。'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @blog.update(blog_params)
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = '変更できません。'
      render :edit
    end
  end

  def destroy
    @blog.destroy
    flash[:notice] = '削除しました。'
    redirect_to user_path(current_user)
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, { images: [] }, :event_id, :user_id)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def q_livehouse
    @q_livehouse = Livehouse.ransack(params[:q])
    @result_livehouses = @q_livehouse.result(distinct: true)
  end
end
