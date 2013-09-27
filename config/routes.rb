Vegspot::Application.routes.draw do

  resources :nodes do
    resources :comments
    member do
      get 'vote/:vote', action: 'vote', as: :vote_on
    end
    collection do
      post 'fetch_title'
    end
    new do
      get 'link', action: 'new', type: 'link'
      get 'text', action: 'new', type: 'text'
    end
  end
  
  get 'recent' => 'nodes#recent', as: :recent_nodes
  get 'saved' => 'nodes#index', as: :saved_nodes, mode: 'saved'

  devise_for :users

  get 'categories' => 'application#categories'
  get 'user/mbajur' => 'application#user'
  get 'lounge' => 'application#lounge'

  get '/users/auth/:service/callback' => 'services#create'
  resources :services, :only => [:index, :create, :destroy]

  root :to => 'nodes#index'
end
