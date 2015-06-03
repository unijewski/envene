class Admin::TaskStatusesController < Admin::AdminController
  before_action :find_task_status, only: [:edit, :update, :destroy]

  def index
    @task_statuses = TaskStatus.all.order(:id).paginate(page: params[:page])
  end

  def show
    @task_status = TaskStatus.find(params[:id]).tasks.order(:id).paginate(page: params[:page])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_task_statuses_path, alert: t('not_found')
  end

  def new
    @task_status = TaskStatus.new
  end

  def create
    @task_status = TaskStatus.new(task_status_params)

    if @task_status.save
      redirect_to admin_task_statuses_path, notice: t('created')
    else
      flash[:alert] = t('error')
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task_status.update(task_status_params)
      redirect_to admin_task_statuses_path, notice: t('updated')
    else
      flash[:alert] = t('error')
      render 'edit'
    end
  end

  def destroy
    @task_status.destroy

    redirect_to admin_task_statuses_path, notice: t('deleted')
  end

  private

  def task_status_params
    params.require(:task_status).permit(:name)
  end

  def find_task_status
    @task_status = TaskStatus.find(params[:id])
  end
end
