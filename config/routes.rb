Rails.application.routes.draw do
  get 'home/index'
  get 'wordpress_template' => 'home#wordpress_template'

  post 'apikey' => 'home#apikey'
  get 'apikey' => 'home#apikey'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  namespace :api, defaults: { format: :json } do
    post 'search' => 'search#search'
    get '/providers/:id' => 'providers#show', as: :provider
    # CORS support
    match '*unmatched_route' => 'cors#render_204', via: [:options]
    match '*unmatched_route' => 'errors#raise_not_found!', via: [:get, :delete, :patch, :post, :put]
  end
  # # just to get rid of annoying sourcemap 404's...
  # match '*path', to: 'search#search', via: :all if Rails.env.development?
end
