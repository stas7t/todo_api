class Api::V1::ProjectsController < ApplicationController

  before_action :set_project, only: %i[show update destroy]
  
  resource_description do
    short 'Projects'
    formats ['json']
  end

  def_param_group :project do
    param :project, Hash do
      param :id, Integer, "ID of the project", required: true
      param :name, String, "Name of the project", required: true
    end
  end

  # GET /projects
  # GET /projects.json
  api :GET, "/projects", "Get list of projects"
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  api :GET, "/projects/:id", "Show specific project"
  param :id, Integer, "ID of the project", required: true
  def show; end

  # POST /projects
  # POST /projects.json
  api :POST, "/projects", "Create a project"
  param_group :project
  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      render json: @project, status: :created
    elsif Project.find_by(name: params[:name])
      render json: { message: 'The project with such name does already exist.' }, status: :conflict
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  api :PUT, "/projects/:id", "Update a project"
  param_group :project
  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  api :DELETE, "/projects/:id", "Delete a project"
  param :id, Integer, "ID of the project", required: true
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
