Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      namespace :auth do
        post 'register', to: 'users#register'
        post 'login',    to: 'users#login'
      end

      root to: 'projects#index'
      resources :projects do
        resources :tasks, only: %i[index create] do
          resources :comments, only: %i[index create]
          resources :deadlines, only: %i[index create]
        end
      end
      resources :tasks, only: %i[show update destroy]
      resources :comments, only: %i[show update destroy]
      resources :deadlines, only: %i[show update destroy]
    end

    namespace :v2 do
      namespace :auth do
        post 'register', to: 'users#register'
        post 'login',    to: 'users#login'
      end

      root to: 'projects#index'
      resources :projects do
        resources :tasks, only: %i[index create] do
          resources :comments, only: %i[index create]
          resources :deadlines, only: %i[index create]
        end
      end
      resources :tasks, only: %i[show update destroy]
      resources :comments, only: %i[show update destroy]
      resources :deadlines, only: %i[show update destroy]
    end
  end
end
