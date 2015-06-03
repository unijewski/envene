class Admin::UsersController < Admin::AdminController
  before_action :find_user, only: [:edit, :update, :destroy]

  def index
    users = User.all.order(:id).paginate(page: params[:page])

    if params[:user]
      @users = users.search(params[:user][:search]).order(:id).paginate(page: params[:page])
    else
      @users = users
    end
  end

  def show
    find_user
    @user_tasks = find_user.tasks.order(:id).paginate(page: params[:page])
    @user_posts = find_user.posts.order(:id).paginate(page: params[:page])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_users_path, alert: t('not_found')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_path(@user), notice: t('created')
    else
      flash[:alert] = t('error')
      render 'new'
    end
  end

  def edit
  end

  def change_password
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      sign_in @user, bypass: true
      redirect_to admin_dashboard_path, notice: t('password')
    else
      render 'edit'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('updated')
    else
      flash[:alert] = t('error')
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_path, notice: t('deleted')
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :admin, :group_id)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
