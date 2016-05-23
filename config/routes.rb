Rails.application.routes.draw do
  
  #namespace :extranet do
  #get 'rules/index'
  #end

  #namespace :extranet do
  #get 'rules/new'
  #end

  #namespace :extranet do
  #get 'rules/create'
  #end

  #namespace :extranet do
  #get 'rules/edit'
  #end

  #namespace :extranet do
  #get 'rules/update'
  #end

  #namespace :extranet do
  #get 'rules/show'
  #end

  #namespace :extranet do
  #get 'rules/destroy'
  #end

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
  
  resources :cases, only:[:show, :index]
  resources :board
  resources :rules, only: [:show, :index]

  #get 'admin/index'
  devise_for :users, controllers: { registrations: "registrations" }
  
  namespace :extranet do
  	resources :cases, :rules, :board_members
  end
end
