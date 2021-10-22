Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root :to => "rooms#index"
    get :confirm, to: "rooms#confirm"
    resources :rooms, only: [:index, :show]
    get :login, to: "sessions#new"
    post :login, to: "sessions#create"
    delete :logout, to: "sessions#destroy"
    post :sessions_update, to: "sessions#update"
    resources :users, only: :show
    resources :booking_details, only: :index
    resources :bookings, only: %i(create index)

    namespace :admin do
        resources :bookings, :booking_details, only: :index
    end

    namespace :staff do
      resources :bookings, :booking_details, only: %i(index)
    end
  end
end
