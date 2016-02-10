Rails.application.routes.draw do
  get 'home/index'
  get 'wordpress_template' => 'home#wordpress_template' if Rails.env.development?

  root 'home#index'

  namespace :api, defaults: { format: :json } do
    resources :providers, only: [:index, :show]

    # CORS support
    match '*unmatched_route' => 'cors#render_204', via: [:options]
    match '*unmatched_route' => 'errors#raise_not_found!', via: [:get, :delete, :patch, :post, :put]
  end
end
