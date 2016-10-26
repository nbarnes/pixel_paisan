
Rails.application.routes.draw do

  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}, :path => "accounts"

  resources :users do
    get 'palettes', to: 'palettes#user_index'
    resources :palettes, except: [:show, :index, :create, :new, :destroy]
    resources :galleries, only: [:index], to: 'galleries#user_index'
  end

  resources :galleries, only: [:show, :index, :create]
  resources :palettes, only: [:show, :index, :create, :new, :destroy] do
    member do
      get 'new_color', as: 'new_color'
      post 'create_color', as: 'create_color'
      delete 'delete_color', as: 'delete_color'
    end
  end

  resources :pictures, only: [:destroy, :create, :update] do
    member do
      get 'editor', to: 'pictures#edit', as: 'edit'
      get '(:size)', to: 'pictures#show', as: 'show'
    end
  end

  resources :snapshots, only: [:show, :destroy]

  namespace :admin do
    resources :users, only: [:index, :show]
    resources :activities, only: [:index]
  end

  get 'admin/activity/:period/:timestamp', to: 'admin/activities#show', as: 'admin_activity'

  get 'admin', to: 'admin/activities#index'

  get 'editor', to: 'static_pages#editor'

  get 'faq', to: 'static_pages#faq'

  root to: redirect('/editor')

  get '/*foo', to: redirect('/editor')

end
