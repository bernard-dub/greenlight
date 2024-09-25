Rails.application.routes.draw do
  get 'streets/show'
  get 'streets/index'
  get 'streets/edit'
  get 'streets/delete'
  get 'cards/comments', to: "cards#comments", as: :cards_comments
  get 'cards/to_print', to: "cards#to_print", as: :cards_to_print
  get 'candidates/comments', to: "candidates#comments", as: :candidates_comments
  resources :cards, :pages, :candidates do
    resources :images
  end
  resources :streets
  devise_for :users
  get 'streets/cards/tagged/*id', to: "streets#cards_tagged", as: :street_cards_tagged
  get 'cards/tagged/*id', to: "cards#tagged", as: :cards_tagged
  get 'cards/:id/like', to: 'cards#like', as: :card_like
  get 'cards/:id/unlike', to: 'cards#unlike', as: :card_unlike
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "cards#index"
end
