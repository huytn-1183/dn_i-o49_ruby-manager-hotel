Rails.application.routes.draw do
  get :denied, to: "permission_denied#index"
  get "booking/index"
  scope "(:locale)", locale: /en|vi/ do
    root :to => "rooms#index"
    resources :rooms, only: [:index]
    get :login, to: "sessions#new"
    post :login, to: "sessions#create"
    delete :logout, to: "sessions#destroy"
    resources :users, only: :show
    resources :bookings, only: [:index]
  end
end
