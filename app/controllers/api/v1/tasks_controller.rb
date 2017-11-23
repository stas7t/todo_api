class Api::V1::TasksController < ApplicationController

  before_action :set_task, only: %i[show update destroy]
  before_action :set_project, only: %i[index create]

  resource_description do
    short 'Tasks'
    formats ['json']
  end

  def_param_group :task do
    param :task, Hash do
      param :id, Integer, "ID of the task", required: true
      param :name, String, "Name of the task", required: true
      param :project_id, Integer, "ID of the task`s project", required: true
    end
  end

  # GET /tasks
  # GET /tasks.json
  api :GET, "/projects/:project_id/tasks", "Get list of tasks"
  param :project_id, Integer, "ID of the task`s project", required: true
  def index
    @tasks = @project.tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  api :GET, "/tasks/:id", "Show specific task"
  param :id, Integer, "ID of the task", required: true
  def show; end

  # POST /tasks
  # POST /tasks.json
  api :POST, "/projects/:project_id/tasks", "Create a task"
  param_group :task
  def create
    @task = @project.tasks.build(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  api :PUT, "/tasks/:id", "Update a task"
  param_group :task
  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  api :DELETE, "/tasks/:id", "Delete a task"
  param :id, Integer, "ID of the task", required: true
  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.permit(:name, :completed, :project_id)
  end
end
