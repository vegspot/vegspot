Vegspot::Application.routes.draw do
  resources :nodes
  match 'recent' => 'nodes#index', as: :recent_nodes, mode: 'recent'
  match 'readed' => 'nodes#index', as: :readed_nodes, mode: 'readed'
  match 'saved' => 'nodes#index', as: :saved_nodes, mode: 'saved'

  devise_for :users

  match 'categories' => 'application#categories'
  match 'user/mbajur' => 'application#user'
  match 'lounge' => 'application#lounge'

  match '/users/auth/:service/callback' => 'services#create'
  resources :services, :only => [:index, :create, :destroy]

  root :to => 'nodes#index'
end
