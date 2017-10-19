class DeadlinesController < ApplicationController
  before_action :set_deadline, only: [:show, :update, :destroy]

  # GET /deadlines
  # GET /deadlines.json
  def index
    @deadlines = Deadline.all
  end

  # GET /deadlines/1
  # GET /deadlines/1.json
  def show
  end

  # POST /deadlines
  # POST /deadlines.json
  def create
    @deadline = Deadline.new(deadline_params)

    if @deadline.save
      render :show, status: :created, location: @deadline
    else
      render json: @deadline.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /deadlines/1
  # PATCH/PUT /deadlines/1.json
  def update
    if @deadline.update(deadline_params)
      render :show, status: :ok, location: @deadline
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
    # Use callbacks to share common setup or constraints between actions.
    def set_deadline
      @deadline = Deadline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deadline_params
      params.require(:deadline).permit(:date, :time)
    end
end
