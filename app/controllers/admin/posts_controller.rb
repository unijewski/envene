class Admin::PostsController < Admin::AdminController
  before_action :find_post, only: [:edit, :update, :destroy]

  def index
    posts = Post.all.order(:id).paginate(page: params[:page])

    if params[:post]
      @posts = posts.search(params[:post][:search]).order(:id).paginate(page: params[:page])
    else
      @posts = posts
    end
  end

  def show
    find_post
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_posts_path, alert: 'The post does not exist!'
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to admin_post_path(@post), notice: 'The post has been created!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'The post has been updated!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @post.destroy

    redirect_to admin_posts_path, notice: 'The post has been deleted!'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :published, :author_id, :category_id)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
