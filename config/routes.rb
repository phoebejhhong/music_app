Rails.application.routes.draw do
  resource :user, only: [:new, :create, :show]
  resources :users, only: [:index] do
    patch "make_admin"
    get "activate", on: :collection
  end
  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new] do
    resources :notes
  end

  root to: "bands#index"
end
