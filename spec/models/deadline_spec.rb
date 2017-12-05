require 'rails_helper'

RSpec.describe Deadline, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }
  let(:task) { FactoryGirl.create(:task, user_id: user.id, project_id: project.id) }
  let(:deadline) { FactoryGirl.create(:deadline, task_id: task.id) }

  it { expect(subject).to belong_to(:task) }
end
