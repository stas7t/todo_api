json.extract! task, :id, :name, :completed, :comments, :deadline, :created_at, :updated_at
json.url task_url(task, format: :json)
