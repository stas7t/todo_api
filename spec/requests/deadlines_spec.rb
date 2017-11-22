require 'rails_helper'

RSpec.describe "Deadlines", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:token) { AuthenticateUser.call(user.username, user.password).result }
  let(:project) { FactoryGirl.create(:project) }
  let(:task) { FactoryGirl.create(:task, project_id: project.id) }
  let(:deadline) { FactoryGirl.create(:deadline, task_id: task.id) }
  let(:deadline_params) { FactoryGirl.attributes_for(:deadline) }

  let(:headers) { {authorization: token, accept: 'application/json'} }

  describe "POST /deadlines" do
    it "creates new deadline" do
      post "/api/v1/projects/#{project.id}/tasks/#{task.id}/deadlines", headers: headers, params: deadline_params
      expect(response).to have_http_status(201)
      expect(response).to match_response_schema('deadline')
    end
  end

  describe "PUT /deadlines" do
    it "creates new comment with file" do
      deadline_params = FactoryGirl.attributes_for(:deadline, :edited)
      post "/api/v1/projects/#{project.id}/tasks/#{task.id}/deadlines", headers: headers, params: deadline_params
      expect(response).to have_http_status(201)
      expect(response).to match_response_schema('deadline')
    end
  end

  describe "DELETE /deadlines/:id" do
    it "delete deadline" do
      delete "/api/v1/deadlines/#{deadline.id}", headers: headers
      expect(response).to have_http_status(204)
    end
  end
end
