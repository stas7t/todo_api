class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show update destroy]
  before_action :set_task, only: %i[create]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @task.comments.new(comment_params)

    if @comment.save
      # render :show, status: :created, location: @comment
      redirect_to root_path
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    if @comment.update(comment_params)
      # render :show, status: :ok, location: @comment
      redirect_to root_path
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
    # params.require(:comment).permit(:text, :file)
    params.permit(:text, :file, :task_id)
  end
end
