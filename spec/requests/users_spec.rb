require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user_params) { FactoryGirl.attributes_for(:user) }

  describe "POST /register" do
    it "registers new user" do
      post api_v1_auth_register_path, params: user_params 
      expect(response).to have_http_status(201)
      expect(response.body).to include('You are successfully registered!')
    end

    it 'do not registers duplicate user' do
      2.times { post api_v1_auth_register_path, params: user_params }
      expect(response).to have_http_status(409)
      expect(response.body).to include('This login already registered')
    end

    context 'invalid user' do
      after(:each) { expect(response).to have_http_status(500) }
      
      it "do not registers user without username" do
        invalid_user = FactoryGirl.attributes_for(:user, :no_username)
        post api_v1_auth_register_path, params: invalid_user 
        expect(response.body).to include('username', "can't be blank")
      end

      it 'do not registers user without password' do
        invalid_user = FactoryGirl.attributes_for(:user, :no_password)
        post api_v1_auth_register_path, params: invalid_user
        expect(response.body).to include('password', "can't be blank")
      end
  
      it 'do not registers user without password_confirmation' do
        invalid_user = FactoryGirl.attributes_for(:user, :no_password_confirmation)
        post api_v1_auth_register_path, params: invalid_user
        expect(response.body).to include("doesn't match Password")
      end
      
      it "do not registers user with lower than min username" do
        invalid_user = FactoryGirl.attributes_for(:user, :lower_than_min_username)
        post api_v1_auth_register_path, params: invalid_user 
        expect(response.body).to include('username', "minimum is 3 characters")
      end
      
      it "do not registers user with greater than max username" do
        invalid_user = FactoryGirl.attributes_for(:user, :greater_than_max_username)
        post api_v1_auth_register_path, params: invalid_user 
        expect(response.body).to include('username', "maximum is 50 characters")
      end
      
      it "do not registers user with lower than min password" do
        invalid_user = FactoryGirl.attributes_for(:user, :lower_than_min_password)
        post api_v1_auth_register_path, params: invalid_user 
        expect(response.body).to include('password', "minimum is 8 characters")
      end
      
      it "do not registers user with only alphanumeric password" do
        invalid_user = FactoryGirl.attributes_for(:user, :no_alphanumeric_password)
        post api_v1_auth_register_path, params: invalid_user 
        expect(response.body).to include('password', "Only alphanumeric allowed")
      end
    end
  end
  
  describe "POST /login" do
    let(:user) { FactoryGirl.create(:user) }

    it "log in user" do
      user
      post api_v1_auth_login_path, params: {username: user.username, password: user.password}
      expect(response).to have_http_status(200)
      expect(response.body).to include('You are successfully logged in!')
    end
    
    context 'invalid user' do
      after(:each) do 
        expect(response).to have_http_status(401)
        expect(response.body).to include('Incorrect login or(and) password')
      end
      
      it 'do not logins user which not existed' do
        invalid_user = FactoryGirl.attributes_for(:user, :no_existing_user)
        post api_v1_auth_login_path, params: invalid_user
      end

      it 'do not logins user with invalid username' do
        invalid_user = FactoryGirl.attributes_for(:user, :no_username)
        post api_v1_auth_login_path, params: invalid_user
      end

      it 'do not logins user with invalid password' do
        invalid_user = FactoryGirl.attributes_for(:user, :no_password)
        post api_v1_auth_login_path, params: invalid_user
      end
    end
  end
end
