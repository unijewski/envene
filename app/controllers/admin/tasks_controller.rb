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
    redirect_to admin_tasks_path, alert: 'The task does not exist!'
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.author = current_user

    if @task.save
      redirect_to admin_task_path(@task), notice: 'The task has been created!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to admin_tasks_path, notice: 'The task has been updated!'
    else
      flash[:alert] = 'Oooups! Something went wrong'
      render 'edit'
    end
  end

  def destroy
    @task.destroy

    redirect_to admin_tasks_path, notice: 'The task has been deleted!'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :progress, :status_id, :priority_id, :author_id)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
