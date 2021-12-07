Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/422', to: 'errors#unprocessable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :plans, only: [:index, :show, :new, :create]  do
    resources :contracts, only: [:new, :create]
    collection do
      get "search"
      post "search_results"
    end
  end

  resources :contracts, only: [:destroy, :index] do
    member do
      get 'confirm'
    end
  end
end
