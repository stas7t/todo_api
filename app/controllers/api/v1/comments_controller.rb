class Api::V1::CommentsController < ApplicationController

  before_action :set_comment, only: %i[show update destroy]
  before_action :set_task, only: %i[index create]

  resource_description do
    short 'Comments'
    formats ['json']
  end

  def_param_group :comment do
    param :comment, Hash do
      param :id, Integer, "ID of the comment", required: true
      param :text, String, "Text of the comment", required: true
      param :file, String, "File attachment to the comment"
      param :project_id, Integer, "ID of the task`s project", required: true
      param :task_id, Integer, "ID of the comment`s task", required: true
    end
  end

  # GET /comments
  # GET /comments.json
  api :GET, "/projects/:project_id/tasks/:task_id/comments", "Get list of comments"
  param :project_id, Integer, "ID of the task`s project", required: true
  param :task_id, Integer, "ID of the comment`s task", required: true
  def index
    @comments = @task.comments
  end

  # GET /comments/1
  # GET /comments/1.json
  api :GET, "/comments/:id", "Show specific comment"
  param :id, Integer, "ID of the comment", required: true
  def show; end

  # POST /comments
  # POST /comments.json
  api :POST, "/projects/:project_id/tasks/:task_id/comments", "Create a comment"
  param_group :comment
  def create
    @comment = @task.comments.build(comment_params)

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  api :PUT, "/comments/:id", "Update a comment"
  param_group :comment
  def update
    if @comment.update(comment_params)
      render json: @task, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  api :DELETE, "/comments/:id", "Delete a comment"
  param :id, Integer, "ID of the comment", required: true
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
    params.permit(:text, :file, :file_cache, :remote_file_url, :task_id)
  end
end
