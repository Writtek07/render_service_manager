Rails.application.routes.draw do
  root 'services#index'
  resources :services do
    collection do
      put :update_schedule      
    end
  end
  post 'update_crontab', to: 'services#update_crontab', as: :update_crontab
  post 'start_service/:id', to: 'services#start_service', as: :start_service
  post 'stop_service/:id', to: 'services#stop_service', as: :stop_service

  get 'pages/index'
  # post 'start_service/:id', to: 'pages#start_service', as: :start_service
  # post 'stop_service/:id', to: 'pages#stop_service', as: :stop_service
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
