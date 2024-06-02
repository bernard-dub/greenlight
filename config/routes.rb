Rails.application.routes.draw do
  resources :cards do
    resources :images
  end
  devise_for :users
  resource :card
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "cards#index"
end
