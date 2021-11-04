Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root :to => "rooms#index"
    get :login, to: "sessions#new"
    post :login, to: "sessions#create"
    delete :logout, to: "sessions#destroy"
    resources :users, only: [:show, :new]
    resources :bookings, only: :index
    resources :rooms, only: [:index, :show]

    namespace :admin do
        resources :bookings, only: :index
        resources :rooms, only: :index do
          collection { 
            get :export 
            post :import 
          }
        end
    end
  end
end
