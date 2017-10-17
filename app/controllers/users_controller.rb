class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]

  # POST /register
  def register
    @user = User.create(user_params)
    if @user.save
      response = { message: 'User created successfully' }
      render json: response, status: :created
    else
      render json: @user.errors, status: :bad
    end
  end

  # POST /login
  def login
    command = AuthenticateUser.call(params[:username], params[:password])

    if command.success?
      render json: { auth_token: command.result,
                     message: 'Login successful' }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
