Rails.application.routes.draw do
  mount_devise_token_auth_for 'Parent', at: 'api/auth', controllers: {
    registrations: 'parents/registrations',
    passwords: 'parents/passwords'
  }

  get 'home/index'
  get 'wordpress_template' => 'home#wordpress_template'

  get 'providers/' => 'home#index'
  get 'providers/:id' => 'home#index'

  get 'compare' => 'home#index'

  get 'reset_password/:reset_token' => 'home#index', as: 'reset_password'
  get 'account' => 'home#index'
  get 'account/:id' => 'home#index'

  root 'home#index'

  namespace :api, defaults: { format: :json } do
    post 'providers' => 'providers#index'
    post 'providers/bulk_fetch' => 'providers#bulk_fetch'
    post 'providers/:id' => 'providers#show'

    resources :favorites, only: [:create, :destroy, :index]

    # CORS support
    match '*unmatched_route' => 'cors#render_204', via: [:options]
    match '*unmatched_route' => 'errors#raise_not_found!', via: [:get, :delete, :patch, :post, :put]
  end
end
