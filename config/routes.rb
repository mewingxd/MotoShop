Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    post "auth/login", to: "auth#login"

    resources :products
    resources :categories, only: %i[index create destroy]
    resources :mechanics
    resources :clients, only: %i[index create]
    resources :sales, only: %i[index create]
    resources :services
    resources :purchases, only: %i[index create]

    namespace :reports do
      get "weekly_sales"
      get "top_products"
      get "daily_sales"
      get "services_summary"
    end

    get "movements", to: "movements#index"
  end
end
