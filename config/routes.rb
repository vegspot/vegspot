Vegspot::Application.routes.draw do

  resources :nodes do
    collection do
      post 'fetch_title'
      get  'saved'
      get  'recent'
    end

    member do
      get  'vote/:vote', action: 'vote', as: :vote_on
      get  'save'
      get  'share'
    end

    resources :comments
  end

  devise_for :users

  get '/users/auth/:service/callback' => 'services#create'
  resources :services, :only => [:index, :create, :destroy]

  root :to => 'nodes#index'
end
