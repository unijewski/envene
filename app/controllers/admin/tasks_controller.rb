class Admin::TasksController < Admin::AdminController
  before_action :find_task, only: [:edit, :update, :destroy]

  def index
    tasks = Task.all.order(:id).paginate(page: params[:page])

    if params[:task]
      @tasks = tasks.search(params[:task][:search]).order(:id).paginate(page: params[:page])
    else
      @tasks = tasks
    end
  end

  def show
    find_task
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_tasks_path, alert: t('task_not_found')
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.author = current_user

    if @task.save
      redirect_to admin_task_path(@task), notice: t('task_created')
    else
      flash[:alert] = t('task_error')
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to admin_tasks_path, notice: t('task_updated')
    else
      flash[:alert] = t('task_error')
      render 'edit'
    end
  end

  def destroy
    @task.destroy

    redirect_to admin_tasks_path, notice: t('task_deleted')
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :progress, :status_id, :priority_id, :author_id)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
