class Admin::TaskStatusesController < Admin::AdminController
  before_action :find_task_status, only: [:edit, :update, :destroy]

  def index
    @task_statuses = TaskStatus.all.order(:id).paginate(page: params[:page])
  end

  def show
    task_status = TaskStatus.find(params[:id])
    @task_status_tasks = task_status.tasks.order(:id).paginate(page: params[:page])
    @task_status_name = task_status.name
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_task_statuses_path, alert: t('task_status_not_found')
  end

  def new
    @task_status = TaskStatus.new
  end

  def create
    @task_status = TaskStatus.new(task_status_params)

    if @task_status.save
      redirect_to admin_task_statuses_path, notice: t('task_status_created')
    else
      flash[:alert] = t('task_status_error')
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task_status.update(task_status_params)
      redirect_to admin_task_statuses_path, notice: t('task_status_updated')
    else
      flash[:alert] = t('task_status_error')
      render 'edit'
    end
  end

  def destroy
    @task_status.destroy

    redirect_to admin_task_statuses_path, notice: t('task_status_deleted')
  end

  private

  def task_status_params
    params.require(:task_status).permit(:name)
  end

  def find_task_status
    @task_status = TaskStatus.find(params[:id])
  end
end
