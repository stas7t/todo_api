class Api::V1::ProjectsController < ApplicationController
  load_and_authorize_resource through: :current_user

  resource_description do
    short 'Projects'
    formats ['json']
  end

  # GET /projects
  # GET /projects.json
  api :GET, "/projects", "Get list of projects"

  def index
    render json: @projects
  end

  # GET /projects/1
  # GET /projects/1.json
  api :GET, "/projects/:id", "Show specific project"
  param :id, String, "ID of the project", required: true

  def show
    render json: @project
  end

  # POST /projects
  # POST /projects.json
  api :POST, "/projects", "Create a project"
  param :name, String, "Name of the project", required: true

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      render json: @project, status: :created
    elsif current_user.projects.find_by(name: params[:name])
      render json: { message: 'The project with such name does already exist.' }, status: :conflict
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  api :PUT, "/projects/:id", "Update a project"
  param :id, String, "ID of the project", required: true
  param :name, String, "Name of the project", required: true

  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    elsif current_user.projects.find_by(name: params[:name])
      render json: { message: 'The project with such name does already exist.' }, status: :conflict
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  api :DELETE, "/projects/:id", "Delete a project"
  param :id, String, "ID of the project", required: true

  def destroy
    @project.destroy
  end

  private

  def project_params
    params.permit(:name, :user_id)
  end
end
