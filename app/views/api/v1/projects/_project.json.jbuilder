json.extract! project, :id, :name, :created_at, :updated_at

json.tasks project.tasks, partial: 'api/v1/tasks/task', as: :task
json.url api_v1_project_url(project, format: :json)
