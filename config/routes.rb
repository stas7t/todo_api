Rails.application.routes.draw do
  resources :comments
  resources :deadlines
  resources :tasks
  resources :projects
  post 'auth/register', to: 'users#register'
  post 'auth/login',    to: 'users#login'
end
