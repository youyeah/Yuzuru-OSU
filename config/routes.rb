Rails.application.routes.draw do

  devise_for :users
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    get 'signup', to: 'devise/registrations#new'
    # signup の post もやるべきかな
    delete 'logout', to: 'devise/sessions#destroy'
  end

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :show, :create, :edit, :update, :destroy] do

    resources :comments, only: [:create]
    
    member do
      post 'status_update'
    end
    
  end

  # resources :posts do
  #   member do
  #     post 'status_update'
  #   end
  # end

  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
