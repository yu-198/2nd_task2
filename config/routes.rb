Rails.application.routes.draw do
  get "search" => "searches#search"
  root to: 'home#top'
  get 'home/about' => 'home#about'

  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  #user_showでformに対して二つの変数を入れていて
  # ネストする必要があるbook_book_comments_pathになっている。
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    end
    resources :books do
      resources :book_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
  end

end