Rails.application.routes.draw do

  root to: 'wallets#index'
  resources :wallets, only: [:index, :show]
  resources :transactions
  resources :internal_transactions, only: :index
  resources :nft_transactions, only: :index
  resources :erc20_transactions, only: :index
  resources :tags do 
    get 'search'
    post 'bulk_update'
  end
  resources :search_transactions  do
    collection do
      get 'query'
      post 'bulk_update'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
