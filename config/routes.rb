Rails.application.routes.draw do
  get 'home/index' if Rails.env.development?
  get 'wordpress_template' => 'home#wordpress_template'

  root 'home#index'

  namespace :api, defaults: { format: :json } do
    post 'providers' => 'providers#index'
    post 'providers/:id' => 'providers#show'

    # CORS support
    match '*unmatched_route' => 'cors#render_204', via: [:options]
    match '*unmatched_route' => 'errors#raise_not_found!', via: [:get, :delete, :patch, :post, :put]
  end
end
