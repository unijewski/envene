class Admin::TaskPriorityTypesController < ApplicationController
  before_action :find_task_priority_type, only: [:edit, :update, :destroy]

  def index
    @task_priority_types = TaskPriorityType.all.order(:id).paginate(page: params[:page])
  end

  def show
    @task_priority_type = TaskPriorityType.find(params[:id]).tasks.order(:id).paginate(page: params[:page])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_task_priority_types_path, alert: t('not_found')
  end

  def new
    @task_priority_type = TaskPriorityType.new
  end

  def create
    @task_priority_type = TaskPriorityType.new(task_priority_type_params)

    if @task_priority_type.save
      redirect_to admin_task_priority_types_path, notice: t('created')
    else
      flash[:alert] = t('error')
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task_priority_type.update(task_priority_type_params)
      redirect_to admin_task_priority_types_path, notice: t('updated')
    else
      flash[:alert] = t('error')
      render 'edit'
    end
  end

  def destroy
    @task_priority_type.destroy

    redirect_to admin_task_priority_types_path, notice: t('deleted')
  end

  private

  def task_priority_type_params
    params.require(:task_priority_type).permit(:name)
  end

  def find_task_priority_type
    @task_priority_type = TaskPriorityType.find(params[:id])
  end
end
