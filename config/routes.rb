Rails.application.routes.draw do

  resources :colors


  resources :palettes do
    member do
      get 'new_color'
      post 'create_color'
    end
  end

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'front_page#welcome'

end
