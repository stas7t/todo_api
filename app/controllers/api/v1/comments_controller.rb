class Api::V1::CommentsController < ApplicationController

  before_action :set_comment, only: %i[show update destroy]
  before_action :set_task, only: %i[create]

  # GET /comments
  # GET /comments.json
  def index
    @comments = @task.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show; end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @task.comments.build(comment_params)

    if @comment.save
      redirect_to api_v1_root_path
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      redirect_to api_v1_root_path
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def comment_params
    params.permit(:text, :file, :task_id)
  end
end
