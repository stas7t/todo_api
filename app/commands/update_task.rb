class UpdateTask
  prepend SimpleCommand

  def initialize(task, params)
    @task = task
    @params = params
  end

  def call
    change_position(@params[:move]) if @params[:move]
    @task.update( { name: @params[:name], completed: @params[:completed], deadline: @params[:deadline] } )
  end

  private

  attr_accessor :task, :params

  def change_position(direction)
    case direction
    when 'up'   then task.move_higher
    when 'down' then task.move_lower
    else false
    end
  end
end
