Rails.application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  root 'welcome#index'
  
  get '/about', to: 'static_pages#about'
  get '/feedback', to: 'static_pages#feedback'
  get 'board/responsibilities', to: 'board#responsibilities'
  
  resources :cases, only: [:show, :index]
  resources :board, only: [:show, :index]
  resources :rules, only: [:show, :index]

  #get 'admin/index'
  devise_for :users, controllers: { registrations: "registrations" }

  
end
