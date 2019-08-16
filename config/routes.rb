Rails.application.routes.draw do
  get "import", to: "import#new"
  post "import", to: "import#create"

  get "unsubscribe", to: "unsubscribe#destroy"

  get "open", to: "open#show"

  resources :feeds do
    get :check, on: :collection
    get :preview, on: :collection
  end

  match "/dj" => DelayedJobWeb, anchor: false, via: [:get, :post]

  resources :announcements, only: [:index]

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
                       masquerades: "admin/masquerades",
                     }

  get "/about", to: "pages#about"
  get "/stats.txt", to: "pages#stats"

  get "/example-email", to: "pages#example"

  root to: "pages#home"

  get "/500", to: "errors#server_error"
  get "/422", to: "errors#unacceptable"
  get "/404", to: "errors#not_found"
end
