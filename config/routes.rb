Rails.application.routes.draw do
  resources :cards do
    resources :images
  end
  devise_for :users
  get 'cards/tagged/*id', to: "cards#tagged", as: :cards_tagged
  resource :card
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "cards#index"
end
