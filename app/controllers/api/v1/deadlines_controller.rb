class Api::V1::DeadlinesController < ApplicationController

  before_action :set_deadline, only: %i[show update destroy]
  before_action :set_task, only: %i[index create]

  # GET /deadlines
  # GET /deadlines.json
  def index
    @deadlines = @task.deadline
  end

  # GET /deadlines/1
  # GET /deadlines/1.json
  def show; end

  # POST /deadlines
  # POST /deadlines.json
  def create
    @deadline = Deadline.new(deadline_params)

    if @deadline.save
      redirect_to api_v1_root_path
    else
      render json: @deadline.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deadlines/1
  # PATCH/PUT /deadlines/1.json
  def update
    if @deadline.update(deadline_params)
      redirect_to api_v1_root_path
    else
      render json: @deadline.errors, status: :unprocessable_entity
    end
  end

  # DELETE /deadlines/1
  # DELETE /deadlines/1.json
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
