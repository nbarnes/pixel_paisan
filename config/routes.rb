
Rails.application.routes.draw do

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}, :path => "accounts"

  resources :users
  resources :pictures, only: [:show, :destroy, :create, :edit, :update]
  resources :snapshots, only: [:show, :destroy]
  resources :galleries, only: [:show, :index]
  resources :colors, only: [:create, :index, :destroy]
  resources :palette_colors, only: [:create, :destroy]

  resources :palettes do
    member do
      get 'new_color', as: 'new_color'
      post 'create_color', to: 'colors#create', as: 'create_color'
    end
  end

  namespace :admin do
   resources :users, only: [:index, :show]
  end

  root 'front_page#welcome'

  get '/*foo', to: redirect('/')

end
