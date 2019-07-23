Rails.application.routes.draw do
  get "import", to: "import#new"
  post "import", to: "import#create"

  resources :feeds do
    get :check, on: :collection
  end

  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

  resources :announcements, only: [:index]
  authenticated :user do
    root to: "feeds#index"
    get "dashboard", to: "dashboard#show"
  end
  devise_for :users, path: "/", path_names: { sign_up: "signup", sign_in: "login", sign_out: "logout", edit: "edit" }, controllers: { masquerades: "admin/masquerades" }
  get "/about", to: "pages#about"

  get "/example-email", to: "pages#example"

  root to: "pages#home"

  get "/500", to: "errors#server_error"
  get "/422", to: "errors#unacceptable"
  get "/404", to: "errors#not_found"
end
