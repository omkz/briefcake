Rails.application.routes.draw do
  resources :feeds
  resource :billing, controller: "sjabloon/billing", only: [:create, :update, :destroy] do
    member do
      get "setup", to: "sjabloon/billing#new", as: "new"
      get "/", to: "sjabloon/billing#show"
    end

    resources :plans, controller: "sjabloon/plans", only: [:index, :update]
  end
  resource :card, controller: "sjabloon/card", only: [:update]
  resources :coupons, controller: "sjabloon/coupons", only: [:index]
  resources :charges, controller: "sjabloon/charges", only: [:show]
  resource :pricing, controller: "sjabloon/pricing", only: [:show]
  post "/webhooks/stripe", to: "stripe_event/webhook#event"

  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

  resources :announcements, only: [:index]
  authenticated :user do
    root to: "feeds#index"
    get "dashboard", to: "dashboard#show"
  end
  devise_for :users, path: "/", path_names: { sign_up: "signup", sign_in: "login", sign_out: "logout", edit: "edit" }, controllers: { masquerades: "admin/masquerades" }
  get "/privacy", to: "pages#privacy"
  get "/terms", to: "pages#terms"
  get "/contact", to: "pages#contact"
  get "/about", to: "pages#about"
  root to: "pages#home"
  get "/500", to: "errors#server_error"
  get "/422", to: "errors#unacceptable"
  get "/404", to: "errors#not_found"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
