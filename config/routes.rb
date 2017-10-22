Rails.application.routes.draw do
  root to: 'projects#index'
  resources :projects do
    resources :tasks do
      resources :comments
      resources :deadlines
    end
  end
  resources :tasks
  resources :comments
  resources :deadlines
  post 'auth/register', to: 'users#register'
  post 'auth/login',    to: 'users#login'
end
