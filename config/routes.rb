Rails.application.routes.draw do
  devise_for :users
  
  root to: "home#index"

  namespace :creator do
    get 'dashboard', to: "dashboard#index"
    get 'bazaar',    to: "bazaar#browse"

    resources :listings
  end

  namespace :publisher do
    get 'dashboard', to: "dashboard#index"
    get 'bazaar',    to: "bazaar#browse"
  end

  get '404', to: 'application#render_404'
  get '*unmatched_route', to: 'application#render_404'
end
