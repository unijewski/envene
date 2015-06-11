module Admin
  class TaskPriorityTypesController < Admin::AdminController
    before_action :find_task_priority_type, only: [:edit, :update, :destroy]

    def index
      @task_priority_types = TaskPriorityType.all.order(:id).paginate(page: params[:page])
    end

    def show
      task_priority_type = TaskPriorityType.find(params[:id])
      @task_priority_type_tasks = task_priority_type.tasks.order(:id).paginate(page: params[:page])
      @task_priority_type_name = task_priority_type.name
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_task_priority_types_path, alert: t('task_priority_type_not_found')
    end

    def new
      @task_priority_type = TaskPriorityType.new
    end

    def create
      @task_priority_type = TaskPriorityType.new(task_priority_type_params)

      if @task_priority_type.save
        redirect_to admin_task_priority_types_path, notice: t('task_priority_type_created')
      else
        flash[:alert] = t('task_priority_type_error')
        render 'new'
      end
    end

    def edit
    end

    def update
      if @task_priority_type.update(task_priority_type_params)
        redirect_to admin_task_priority_types_path, notice: t('task_priority_type_updated')
      else
        flash[:alert] = t('task_priority_type_error')
        render 'edit'
      end
    end

    def destroy
      @task_priority_type.destroy

      redirect_to admin_task_priority_types_path, notice: t('task_priority_type_deleted')
    end

    private

    def task_priority_type_params
      params.require(:task_priority_type).permit(:name)
    end

    def find_task_priority_type
      @task_priority_type = TaskPriorityType.find(params[:id])
    end
  end
end
