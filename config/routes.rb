Rails.application.routes.draw do

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}, :path => "accounts"

  resources :users
  resources :pictures, only: [:show, :destroy, :edit]
  resources :snapshots, only: [:create, :show, :destroy]
  resources :galleries, only: [:show, :index]
  resources :colors, only: [:create, :index, :destroy]
  resources :palette_colors, only: [:create, :destroy]

  resources :palettes do
    member do
      get 'new_color'
      post 'create_color'
    end
  end

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'front_page#welcome'

end
