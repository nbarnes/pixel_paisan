
Rails.application.routes.draw do

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}, :path => "accounts"

  resources :users do
    get 'palettes', to: 'palettes#user_index'
    resources :palettes, except: [:show, :index]
    resources :galleries, only: [:index], to: 'galleries#user_index'
  end

  resources :galleries, only: [:show, :index]
  resources :palettes, only: [:show, :index] do
    member do
      post 'create_color', as: 'create_color'
      delete 'delete_color', as: 'delete_color'
    end
  end

  resources :pictures, only: [:show, :destroy, :create, :edit, :update]
  resources :snapshots, only: [:show, :destroy]

  namespace :admin do
   resources :users, only: [:index, :show]
   resources :activities, only: [:index]
  end

  get 'faq', to: 'faq#faq'

  root 'front_page#welcome'

  get '/*foo', to: redirect('/')

end
