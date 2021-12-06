Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :plans, only: [:index, :show, :new, :create]  do
    resources :contracts, only: [:new, :create]
    collection do
      get "search"
      post "search_results"
    end
  end

  resources :contracts, only: [:destroy, :index] do
    resources :payments, only: :new
    member do
      get 'confirm'
    end
  end
end
