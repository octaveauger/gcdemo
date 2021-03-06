Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :admins, :controllers => { :omniauth_callbacks => "admins/omniauth_callbacks" }
  
  scope '/control' do
    resources :merchants, path: 'merchants' do
      resources :payment_templates, path: 'payments'
      resources :subscription_templates, path: 'subscriptions'
    end
  end

  localized do
    scope '/demo/:admin_slug/:merchant_slug/' do
      resources :customers, only: [:new, :create]
      get 'start', to: 'flow#home', as: 'flow_start'
      get 'representation', to: 'flow#representation', as: 'flow_representation'
      get 'confirmation', to: 'flow#confirmation', as: 'flow_confirmation'
      get 'mandate-pdf', to: 'flow#pdf', as: 'flow_mandate_pdf'
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
end
