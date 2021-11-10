Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root :to => "rooms#index"
    resources :rooms, only: [:index, :show]
    get :login, to: "sessions#new"
    post :login, to: "sessions#create"
    delete :logout, to: "sessions#destroy"
    resources :users, only: :show
    resources :bookings, only: :index
    namespace :admin do
        resources :bookings, only: :index
    end
  end
end
