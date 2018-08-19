Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users
  
  root to: "home#index"

  namespace :creator do
    get 'dashboard', to: "dashboard#index"
    get 'bazaar/browse',    to: "bazaar#browse"

    resources :conversations, only: [:index, :show] do
      resources :messages, only: [:create]
    end
    get 'conversations/publisher/:id', to: "conversations#publisher"
    resources :videos
    resources :publishers, only: [:show]
  end

  namespace :publisher do
    get 'dashboard', to: "dashboard#index"
    get 'bazaar',    to: "bazaar#browse"

    resources :creators, only: [:show]
    resources :conversations, only: [:index, :show] do
      resources :messages, only: [:create]
    end
    get 'conversations/creator/:id', to: "conversations#creator"
  end

  get '404', to: 'application#render_404'
  get '*unmatched_route', to: 'application#render_404'
end
