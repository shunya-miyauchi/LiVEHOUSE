class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update destroy]
  before_action :q_livehouse
  before_action :q_blog, only: %i[index]

  def index
    respond_to do |format|
      format.html {}
      format.js { render :schedule }
    end
  end

  def new
    @blog = Blog.new
    @events = current_user.join_events.date_before_today
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blogs_path, flash: { blog_notice: 'ブログ投稿'}
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, flash: { blog_notice: 'ブログ削除'}
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

  # 期間検索
  def q_blog
    @q_blog = Blog.ransack(params[:date_search], search_key: :date_search)
    @blogs =
      if @q_blog.conditions.present?
        @q_blog.result.includes(:event).order("events.held_on").page(params[:page]).per(10)
      else
        Blog.where(user_id: current_user.id).includes(:event).reverse_event_held_on.page(params[:page]).per(10)
      end
  end
end
