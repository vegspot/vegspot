Vegspot::Application.routes.draw do
  post 'nodes/fetch_title' => 'nodes#fetch_title', as: :fetch_link_title
  resources :nodes
  get 'recent' => 'nodes#index', as: :recent_nodes, mode: 'recent'
  get 'readed' => 'nodes#index', as: :readed_nodes, mode: 'readed'
  get 'saved' => 'nodes#index', as: :saved_nodes, mode: 'saved'

  devise_for :users

  get 'categories' => 'application#categories'
  get 'user/mbajur' => 'application#user'
  get 'lounge' => 'application#lounge'

  get '/users/auth/:service/callback' => 'services#create'
  resources :services, :only => [:index, :create, :destroy]

  root :to => 'nodes#index'
end
