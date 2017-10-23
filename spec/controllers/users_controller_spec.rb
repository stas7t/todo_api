require 'rails_helper'

RSpec.describe Api::V1::Auth::UsersController, type: :controller do
  describe 'POST #register' do
    it 'registers new user' do
      user_attrs = FactoryGirl.attributes_for(:user)
      post :register, params: user_attrs
      expect(response.status).to eq(201)
    end

    it 'do not registers duplicate user' do
      user_attrs = FactoryGirl.attributes_for(:user)
      2.times { post :register, params: user_attrs }
      expect(response.status).to eq(409)
    end

    it 'do not registers user without username' do
      user_attrs = FactoryGirl.attributes_for(:user, username: '')
      post :register, params: user_attrs
      expect(response.status).to eq(500)
    end

    it 'do not registers user without password' do
      user_attrs = FactoryGirl.attributes_for(:user, password: '')
      post :register, params: user_attrs
      expect(response.status).to eq(500)
    end

    it 'do not registers user without password_confirmation' do
      user_attrs = FactoryGirl.attributes_for(:user, password_confirmation: '')
      post :register, params: user_attrs
      expect(response.status).to eq(500)
    end
  end

  describe 'POST #login' do
    before { FactoryGirl.create(:user) }

    it 'logins user' do
      user_attrs = FactoryGirl.attributes_for(:user)
      post :login, params: user_attrs
      expect(response.status).to eq(200)
    end

    it 'do not logins user which not existed' do
      user_attrs = FactoryGirl.attributes_for(:user, username: 'not_a_user')
      post :login, params: user_attrs
      expect(response.status).to eq(401)
    end

    it 'do not logins user with invalid username' do
      user_attrs = FactoryGirl.attributes_for(:user, username: 'x')
      post :login, params: user_attrs
      expect(response.status).to eq(401)
    end

    it 'do not logins user with invalid password' do
      user_attrs = FactoryGirl.attributes_for(:user, password: 'x')
      post :login, params: user_attrs
      expect(response.status).to eq(401)
    end
  end
end
