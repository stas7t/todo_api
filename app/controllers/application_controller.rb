class ApplicationController < ActionController::API
  before_action :authenticate_request
  before_action :current_ability, except: [:login, :register]

  attr_reader :current_user
  attr_reader :current_ability

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def current_ability
    @current_ability ||= Ability.new(AuthorizeApiRequest.call(request.headers).result)
  end
end
