require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }
  let(:task) { FactoryGirl.create(:task, user_id: user.id, project_id: project.id) }
  let(:comment) { FactoryGirl.create(:comment, task_id: task.id) }

  it { expect(subject).to validate_presence_of :text }

  it { expect(subject).to belong_to(:task) }
end
