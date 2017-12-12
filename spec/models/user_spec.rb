require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.create(:user) }

  it { expect(subject).to validate_presence_of :username }
  it { expect(subject).to validate_confirmation_of :password }
  it { expect(subject).to validate_length_of :password }
  it { expect(subject).to validate_length_of :username }
  it { expect(subject).to validate_uniqueness_of :username }

  it { expect(subject).to allow_value('test user').for(:username) }
  it { expect(subject).not_to allow_value('x').for(:username) }
  it { expect(subject).not_to allow_value('x' * 51).for(:username) }

  it { expect(subject).to allow_value('password1234').for(:password) }
  it 'do not allow special characters for password' do
    "!#$%&'( )*+,-./:;<=>?@[\]^_`{|}~\"".split.each do |char|
      expect(subject).not_to allow_value("password#{char}").for(:password)
    end
  end

  it { expect(subject).to have_many(:projects) }
end
