Rails.application.routes.draw do
  root 'books#index', defaults: { home: true }
  get 'about', to: 'pages#about'
  resources :books, only: [:index, :show]
  resources :categories, only: [:show]
  get 'search', to: 'books#search'
end
