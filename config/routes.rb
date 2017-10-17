Rails.application.routes.draw do
  post 'auth/register', to: 'users#register'
  post 'auth/login',    to: 'users#login'
end
