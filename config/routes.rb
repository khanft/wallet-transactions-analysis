Rails.application.routes.draw do

  root to: 'wallets#index'
  resources :wallets, only: [:index, :show]
  resources :transactions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
