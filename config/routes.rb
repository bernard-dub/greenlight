Rails.application.routes.draw do
  get 'cards/comments', to: "cards#comments", as: :cards_comments
  get 'candidates/comments', to: "candidates#comments", as: :candidates_comments
  resources :cards, :pages, :candidates do
    resources :images
  end
  devise_for :users
  get 'cards/tagged/*id', to: "cards#tagged", as: :cards_tagged
  get 'cards/:id/like', to: 'cards#like', as: :card_like
  get 'cards/:id/unlike', to: 'cards#unlike', as: :card_unlike
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "cards#index"
end
