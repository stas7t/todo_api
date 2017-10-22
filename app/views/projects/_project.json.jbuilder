json.extract! project, :id, :name, :created_at, :updated_at

json.tasks project.tasks, partial: 'tasks/task', as: :task
json.url project_url(project, format: :json)
