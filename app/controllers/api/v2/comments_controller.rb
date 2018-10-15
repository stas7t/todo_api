class Api::V2::CommentsController < ApplicationController
  load_and_authorize_resource :project, through: :current_user
  load_and_authorize_resource :task, through: :project
  load_and_authorize_resource through: :task, shallow: true

  resource_description do
    short 'Comments'
    formats ['json']
  end

  def_param_group :comment do
    param :text, String, "Text of the comment", required: true
    param :file, String, "File attachment to the comment"
  end

  # GET /comments
  # GET /comments.json
  api :GET, "/projects/:project_id/tasks/:task_id/comments", "Get list of comments"
  param :project_id, String, "ID of the task`s project", required: true
  param :task_id, String, "ID of the comment`s task", required: true

  def index
    render json: @comments.as_json
  end

  # GET /comments/1
  # GET /comments/1.json
  api :GET, "/comments/:id", "Show specific comment"
  param :id, String, "ID of the comment", required: true

  def show
    render json: @comment.as_json
  end

  # POST /comments
  # POST /comments.json
  api :POST, "/projects/:project_id/tasks/:task_id/comments", "Create a comment"
  param :project_id, String, "ID of the task`s project", required: true
  param :task_id, String, "ID of the comment`s task", required: true
  param_group :comment

  def create
    @comment = @task.comments.build(comment_params)

    if @comment.save
      render json: @comment.as_json, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  api :PUT, "/comments/:id", "Update a comment"
  param :id, String, "ID of the comment", required: true
  param_group :comment

  def update
    if @comment.update(comment_params)
      render json:  @comment.as_json, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  api :DELETE, "/comments/:id", "Delete a comment"
  param :id, String, "ID of the comment", required: true

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.permit(:text, :file, :file_cache, :remote_file_url, :task_id)
  end
end
