Rails.application.routes.draw do

  devise_for :users
  resources :colors, only: [:create, :index, :destroy]

  resources :palettes do
    member do
      get 'new_color'
      post 'create_color'
    end
  end

  resources :palette_colors, only: [:create, :destroy]

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'front_page#welcome'

end
