class Api::V1::DeadlinesController < ApplicationController

  before_action :set_deadline, only: %i[show update destroy]
  before_action :set_task, only: %i[index create]

  resource_description do
    short 'Deadlines'
    formats ['json']
  end

  def_param_group :deadline do
    param :date, String, "Date of the deadline", required: true
    param :time, String, "Time of the deadline", required: true
  end

  # GET /deadlines
  # GET /deadlines.json
  api :GET, "/projects/:project_id/tasks/:task_id/deadlines", "Get list of deadlines"
  param :project_id, String, "ID of the task`s project", required: true
  param :task_id, String, "ID of the deadline`s task", required: true

  def index
    @deadlines = @task.deadline
  end

  # GET /deadlines/1
  # GET /deadlines/1.json
  api :GET, "/deadlines/:id", "Show specific deadline"
  param :id, String, "ID of the deadline", required: true

  def show; end

  # POST /deadlines
  # POST /deadlines.json
  api :POST, "/projects/:project_id/tasks/:task_id/deadlines", "Create a deadline"
  param :project_id, String, "ID of the task`s project", required: true
  param :task_id, String, "ID of the deadline`s task", required: true
  param_group :deadline

  def create
    @deadline = Deadline.new(deadline_params)

    if @deadline.save
      render json: @deadline, status: :created
    else
      render json: @deadline.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deadlines/1
  # PATCH/PUT /deadlines/1.json
  api :PUT, "/deadlines/:id", "Update a deadline"
  param :id, String, "ID of the deadline", required: true
  param_group :deadline

  def update
    if @deadline.update(deadline_params)
      render json: @deadline, status: :ok
    else
      render json: @deadline.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deadlines/1
  # DELETE /deadlines/1.json
  api :DELETE, "/deadlines/:id", "Delete a deadline"
  param :id, String, "ID of the deadline", required: true

  def destroy
    @deadline.destroy
  end

  private

  def set_deadline
    @deadline = Deadline.find(params[:id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def deadline_params
    params.permit(:date, :time, :task_id)
  end
end
