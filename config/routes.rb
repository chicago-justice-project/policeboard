Rails.application.routes.draw do
  get '/history', to: 'history#index'
  get '/history/all', to: 'history#all'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/about', to: 'static_pages#about'
  get '/feedback', to: 'static_pages#feedback'
  get 'board/responsibilities', to: 'board#responsibilities'

  resources :cases, only:[:show, :index]
  resources :board
  resources :rules, only: [:show, :index]

  resources :analytics, only: [:show, :index]

  #get 'admin/index'
  devise_for :users, controllers: { registrations: "registrations" }

  namespace :extranet do
    resources :rules, :board_members, :superintendents
    resources :board_members do
      resources :terms, only:[:create, :destroy]
    end
    resources :cases do
      resources :case_files, only:[:destroy]
      resources :minority_opinions, only:[:create, :destroy]
    end
  end
end
