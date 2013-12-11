Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :store_credits do
      get :history, :on => :member
    end
    resources :users do
      resources :store_credits
    end
  end
end
