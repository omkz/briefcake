Rails.application.routes.draw do

  authenticated :user do
    root to: "feeds#index"
  end

  devise_for :users, path: "/",
                     path_names: {
                       sign_up: "signup",
                       sign_in: "login",
                       sign_out: "logout",
                       edit: "edit",
                     },
                     controllers: {
                       confirmations: "confirmations",
                       masquerades: "admin/masquerades",
                       registrations: "users/registrations",
                       sessions: "users/sessions"
                     } do
  end

  devise_scope :user do
    get "confirmed", to: "confirmations#confirmed"
  end

  # Delayed Job Web is a web interface for viewing/managing jobs
  match "/dj" => DelayedJobWeb, anchor: false, via: [:get, :post]

  # webhook endpoint for paddle service
  post "paddle/hook"

  ## enduser endpoints
  # generic renders
  root to: "pages#home"
  get "thank-you", to: "pages#thankyou"
  get "/about", to: "pages#about"
  get "/pro", to: redirect("/plans")
  get "/pricing", to: redirect("/plans")
  get "/plans", to: "pages#plans"
  get "/stats.txt", to: "pages#stats"
  get "/example-email", to: "pages#example"
  get "about/rss-newsletter", to: "pages#subscribe"
  get "/creators", to: "pages#creators"
  get "/500", to: "errors#server_error"
  get "/422", to: "errors#unacceptable"
  get "/404", to: "errors#not_found"

  ## more dynamic
  get "subscribe/show"

  patch 'brief_cake_transition/has_seen_briefcake'

  post "import", to: "import#create"
  get "import", to: "import#new"

  get "unsubscribe", to: "unsubscribe#destroy"

  get "open", to: "open#show"
  get "open/jobs", to: "open#jobs"

  resource :subscribe_form, controller: :subscribe_form, only: [:edit, :update]
  get "/s/:slug", controller: :subscribe, action: :show
  post "/s/:slug", controller: :subscribe, action: :subscribe, as: :subscribe

  resources :feeds do
    get :check, on: :collection
    get :preview, on: :collection
  end

  resources :announcements, only: [:index]

end
