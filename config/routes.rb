Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  #user_showでformに対して二つの変数を入れていて
  # ネストする必要があるbook_book_comments_pathになっている。
  resources :books do
  		resources :book_comments, only: [:create, :destroy]
  		resource :favorites, only: [:create, :destroy]
  	end

  root to: 'home#top'
  get 'home/about' => 'home#about'
end