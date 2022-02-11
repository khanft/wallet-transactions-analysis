Rails.application.routes.draw do

  root to: 'wallets#index'
  resources :wallets, only: [:index, :show]
  resources :transactions
  resources :tags do 
    get 'search'
    post 'bulk_update'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
