Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"

  namespace :creator do
    get 'dashboard', to: "dashboard#index"
    get 'bazaar/browse',    to: "bazaar#browse"

    resources :conversations, only: [:index, :show] do
      resources :messages, only: [:create]
    end
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
  end

  get '404', to: 'application#render_404'
  get '*unmatched_route', to: 'application#render_404'
end
