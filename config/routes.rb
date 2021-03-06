Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update, :show, :index]

  resources :advertisements, only: [:index, :show]
  resources :question

       resources :topics do
     resources :posts, except: [:index]
   end

   resources :posts, only: [] do
     resources :comments, only: [:create, :destroy]
     resources :favorites, only: [:create, :destroy]

     post '/up-vote' => 'votes#up_vote', as: :up_vote
     post '/down-vote' => 'votes#down_vote', as: :down_vote
   end

  get 'about' => 'welcome#about'

  get 'contact' => 'welcome#contact'
  
  get "faq" => 'welcome#faq'



  
  root to: 'welcome#index'
end

