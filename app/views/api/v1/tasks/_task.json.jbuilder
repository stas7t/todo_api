json.extract! task, :id, :name, :completed, :comments, :deadline, :created_at, :updated_at, :project_id
json.url api_v1_task_url(task, format: :json)
