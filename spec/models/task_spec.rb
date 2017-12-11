require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }
  let(:task) { FactoryGirl.create(:task, project_id: project.id) }

  it { expect(subject).to validate_presence_of :name }

  it { expect(subject).to belong_to(:project) }
  it { expect(subject).to have_many(:comments) }
end
