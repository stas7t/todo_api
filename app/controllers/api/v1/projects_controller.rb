class Api::V1::ProjectsController < ApplicationController

  before_action :set_project, only: %i[show update destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show; end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      # redirect_to api_v1_root_path
      render :index
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      redirect_to api_v1_root_path
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.permit(:name, :user_id)
  end
end
