module Admin
  class PostCategoriesController < Admin::AdminController
    before_action :find_post_category, only: [:edit, :update, :destroy]

    def index
      @post_categories = PostCategory.all.order(:id).paginate(page: params[:page])
    end

    def show
      post_category = PostCategory.find(params[:id])
      @post_category_posts = post_category.posts.order(:id).paginate(page: params[:page])
      @post_category_name = post_category.name
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_post_categories_path, alert: t('post_category_not_found')
    end

    def new
      @post_category = PostCategory.new
    end

    def create
      @post_category = PostCategory.new(post_category_params)

      if @post_category.save
        redirect_to admin_post_categories_path, notice: t('post_category_created')
      else
        flash[:alert] = t('post_category_error')
        render 'new'
      end
    end

    def edit
    end

    def update
      if @post_category.update(post_category_params)
        redirect_to admin_post_categories_path, notice: t('post_category_updated')
      else
        flash[:alert] = t('post_category_error')
        render 'edit'
      end
    end

    def destroy
      @post_category.destroy

      redirect_to admin_post_categories_path, notice: t('post_category_deleted')
    end

    private

    def post_category_params
      params.require(:post_category).permit(:name)
    end

    def find_post_category
      @post_category = PostCategory.find(params[:id])
    end
  end
end
