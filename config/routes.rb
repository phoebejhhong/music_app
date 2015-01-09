Rails.application.routes.draw do
  resource :user, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :bands
  resources :albums, except: [:index]
  resources :tracks, except: [:index] do
    resources :notes
  end

  root to: "bands#index"
end
