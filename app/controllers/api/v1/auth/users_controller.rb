class Api::V1::Auth::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]

  resource_description do
    short 'App users'
    formats ['json']
  end

  # POST /register
  api :POST, '/register', 'Register user in the app'
  param :username, String, desc: 'Username for login', required: true
  param :password, String, desc: 'Password for login', required: true
  param :password_confirmation, String, desc: 'Password confirmation', required: true
  def register
    @user = User.create(user_params)

    if @user.save
      command = AuthenticateUser.call(@user.username, @user.password)

      response = { auth_token: command.result,
                   message: 'You are successfully registered!' }
      render json: response, status: :created
    elsif User.find_by(username: params[:username])
      render json: { message: 'This login already registered. Please, log in.' }, status: :conflict
    else
      render json: @user.errors, status: :bad
    end
  end

  # POST /login
  api :POST, '/login', 'Log in user in the app'
  param :username, String, desc: 'Username for login', required: true
  param :password, String, desc: 'Password for login', required: true
  error code: 401, desc: 'Unauthorized'
  def login
    command = AuthenticateUser.call(params[:username], params[:password])

    if command.success?
      render json: { auth_token: command.result,
                     message: 'You are successfully logged in!' }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
