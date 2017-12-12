require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user_id: user.id) }

  it { expect(subject).to validate_presence_of :name }

  it { expect(subject).to belong_to(:user) }
  it { expect(subject).to have_many(:tasks) }
end
