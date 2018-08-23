Rails.application.routes.draw do
  root :to => "home#index", :id => "1"
  get 'home/index'
  devise_for :users
  resources :users

  get 'tags', to: 'home#index', as: :tag, constraints: { tag: %r{/[^\/]+/ }}

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :show]
      devise_scope :user do
        match '/sessions' => 'sessions#create', via: :post
        match '/sessions' => 'sessions#destroy', via: :delete
      end
    end
  end

end
