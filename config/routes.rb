Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "rooms#index"

    devise_for :users, controllers: {
      registrations: "users/registrations",
    }

    resources :rooms, only: [:index, :show]
    resources :bookings, only: :index
    resources :users, only: [:show, :index]

    namespace :admin do
      resources :bookings, only: :index
    end
  end
end
