class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update destroy]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
    @events = current_user.join_events.date_before_today
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to blogs_path
    else
      flash.now[:alert] = '保存できません。'
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @blog.update
      redirect_to blogs_path
    else
      flash.now[:alert] = '変更できません。'
      render :edit
    end
  end

  def destroy
    @blog.destroy
    flash[:notice] = '削除しました。'
    redirect_to blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, { image: [] }, :event_id, :user_id)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
