class Admin::PostCategoriesController < ApplicationController
  before_action :find_post_category, only: [:edit, :update, :destroy]

  def index
    @post_categories = PostCategory.all.order(:id).paginate(page: params[:page])
  end

  def show
    @post_category = PostCategory.find(params[:id]).posts.order(:id).paginate(page: params[:page])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_post_categories_path, alert: t('not_found')
  end

  def new
    @post_category = PostCategory.new
  end

  def create
    @post_category = PostCategory.new(post_category_params)

    if @post_category.save
      redirect_to admin_post_categories_path, notice: t('created')
    else
      flash[:alert] = t('error')
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post_category.update(post_category_params)
      redirect_to admin_post_categories_path, notice: t('updated')
    else
      flash[:alert] = t('error')
      render 'edit'
    end
  end

  def destroy
    @post_category.destroy

    redirect_to admin_post_categories_path, notice: t('deleted')
  end

  private

  def post_category_params
    params.require(:post_category).permit(:name)
  end

  def find_post_category
    @post_category = PostCategory.find(params[:id])
  end
end
