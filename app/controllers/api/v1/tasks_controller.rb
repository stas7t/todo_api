class Api::V1::TasksController < ApplicationController
  load_and_authorize_resource :project, through: :current_user
  load_and_authorize_resource through: :project, shallow: true

  resource_description do
    short 'Tasks'
    formats ['json']
  end

  # GET /tasks
  # GET /tasks.json
  api :GET, "/projects/:project_id/tasks", "Get list of tasks"
  param :project_id, String, "ID of the task`s project", required: true

  def index
    render json: @tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  api :GET, "/tasks/:id", "Show specific task"
  param :id, String, "ID of the task", required: true

  def show
    render json: @task
  end

  # POST /tasks
  # POST /tasks.json
  api :POST, "/projects/:project_id/tasks", "Create a task"
  param :project_id, String, "ID of the task`s project", required: true
  param :name, String, "Name of the task", required: true

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
  param :id, String, "ID of the task", required: true
  param :name, String, "Name of the task", required: true
  param :move, String, "Direction of the task move", required: false

  def update
    command = UpdateTask.call(@task, task_params)

    if command.result
      render json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  api :DELETE, "/tasks/:id", "Delete a task"
  param :id, String, "ID of the task", required: true

  def destroy
    @task.destroy
  end

  private

  def task_params
    params.permit(:name, :completed, :deadline, :project_id, :move)
  end
end
