require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:token) { AuthenticateUser.call(user.username, user.password).result }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }
  let(:task) { FactoryGirl.create(:task, project_id: project.id) }
  let(:comments) { FactoryGirl.create_list(:comment, 3, task_id: task.id) }
  let(:comment) { FactoryGirl.create(:comment, task_id: task.id) }
  let(:comment_params) { FactoryGirl.attributes_for(:comment) }

  let(:headers) { {authorization: token, accept: 'application/json'} }

  describe "GET /comments" do
    it "gets list of comments" do
      comments
      get "/api/v1/projects/#{project.id}/tasks/#{task.id}/comments", headers: headers
      expect(response).to have_http_status(200)
      expect(response).to match_response_schema('comments')
      expect(response.parsed_body.size).to eq(3)
    end
  end

  describe "POST /comments" do
    it "creates new comment" do
      post "/api/v1/projects/#{project.id}/tasks/#{task.id}/comments", headers: headers, params: comment_params
      expect(response).to have_http_status(201)
      expect(response).to match_response_schema('comment')
    end
  end

  describe "POST /comments" do
    it "creates new comment with file" do
      comment_params = FactoryGirl.attributes_for(:comment, :with_file)
      post "/api/v1/projects/#{project.id}/tasks/#{task.id}/comments", headers: headers, params: comment_params
      expect(response).to have_http_status(201)
      expect(response).to match_response_schema('comment_with_file')
    end
  end

  describe "DELETE /comments/:id" do
    it "delete comments" do
      delete "/api/v1/comments/#{comment.id}", headers: headers
      expect(response).to have_http_status(204)
    end
  end
end
