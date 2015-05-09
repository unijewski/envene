class Admin::UserGroupsController < Admin::AdminController
  before_action :find_user_group, only: [:edit, :update, :destroy]

  def index
    @user_groups = UserGroup.all.order(:id).paginate(page: params[:page])
  end

  def show
    @user_group = UserGroup.find(params[:id]).users.order(:id).paginate(page: params[:page])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_user_groups_path, alert: 'The user group does not exist!'
  end

  def new
    @user_group = UserGroup.new
  end

  def create
    @user_group = UserGroup.new(user_group_params)

    if @user_group.save
      redirect_to admin_user_groups_path, notice: 'The user group has been created!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user_group.update(user_group_params)
      redirect_to admin_user_groups_path, notice: 'The user group has been updated!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @user_group.destroy

    redirect_to admin_user_groups_path, notice: 'The user group has been deleted!'
  end

  private

  def user_group_params
    params.require(:user_group).permit(:name)
  end

  def find_user_group
    @user_group = UserGroup.find(params[:id])
  end
end
