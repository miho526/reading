Rails.application.routes.draw do
  root to: 'toppages#index'
  
  post 'isbn', to:'books#isbn'
  resources :books, only: [:show]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :my_books
      get :my_posts
      get :likes
    end
  end
  
  resources :posts, except: [:show]
  
  post 'read', to: 'shelves#read'
  resources :shelves, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end