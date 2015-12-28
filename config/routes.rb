require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}, :path => "accounts"

  resources :users
  resources :pictures, only: [:show, :destroy, :edit] do
    member do
      post 'change_name', to: 'pictures#change_name', as: 'change_picture_name'
    end
  end
  resources :snapshots, only: [:create, :show, :destroy]
  resources :galleries, only: [:show, :index]
  resources :colors, only: [:create, :index, :destroy]
  resources :palette_colors, only: [:create, :destroy]

  resources :palettes do
    member do
      get 'new_color', as: 'new_color'
      post 'create_color', to: 'colors#create', as: 'create_color'
    end
  end

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'front_page#welcome'

  get '/*foo', to: redirect('/')

end
