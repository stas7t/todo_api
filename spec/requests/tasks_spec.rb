require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:token) { AuthenticateUser.call(user.username, user.password).result }
  let(:project) { FactoryGirl.create(:project) }
  let(:tasks) { FactoryGirl.create_list(:task, 3, project_id: project.id) }
  let(:task) { FactoryGirl.create(:task, project_id: project.id) }
  let(:task_params) { FactoryGirl.attributes_for(:task) }

  let(:headers) { {authorization: token, accept: 'application/json'} }

  describe "GET /tasks" do
    it "gets list of tasks" do
      tasks
      get "/api/v1/projects/#{project.id}/tasks", headers: headers
      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('tasks')
      expect(response.parsed_body.size).to eq(3)
    end
  end

  describe "POST /tasks" do
    it "creates new task" do
      post "/api/v1/projects/#{project.id}/tasks", headers: headers, params: task_params
      expect(response).to have_http_status(201)
      expect(response).to match_response_schema('task')
    end
  end

  describe "PUT /tasks/:id" do
    it "update tasks" do
      edited_task = FactoryGirl.attributes_for(:task, :edited)
      put "/api/v1/tasks/#{task.id}", headers: headers, params: edited_task
      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('tasks')
      expect(response.body).to include('edited name')
    end
  end

  describe "DELETE /tasks/:id" do
    it "delete tasks" do
      delete "/api/v1/tasks/#{task.id}", headers: headers
      expect(response).to have_http_status(204)
    end
  end
end
