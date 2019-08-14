Rails.application.routes.draw do
  get 'subscribe/show'
  get "import", to: "import#new"
  post "import", to: "import#create"

  get "unsubscribe", to: "unsubscribe#destroy"

  get "open", to: "open#show"

  resource :subscribe_form, controller: :subscribe_form, only: [:edit, :update]
  get "/s/:slug", controller: :subscribe, action: :show
  post "/s/:slug", controller: :subscribe, action: :subscribe, as: :subscribe

  devise_scope :user do
    get "confirmed", to: "confirmations#confirmed"
  end

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
                       confirmations: "confirmations",
                       masquerades: "admin/masquerades",
                     } do

                     end

  get "/about", to: "pages#about"
  get "/stats.txt", to: "pages#stats"

  get "/example-email", to: "pages#example"

  get "about/rss-newsletter", to: "pages#subscribe"

  root to: "pages#home"

  get "/500", to: "errors#server_error"
  get "/422", to: "errors#unacceptable"
  get "/404", to: "errors#not_found"
end
