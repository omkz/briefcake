Rails.application.routes.draw do

  authenticated :user do
    root to: 'feeds#index', as: :authenticated_root
  end

  devise_for :users, path: '/',
                     path_names: {
                       sign_up: 'signup',
                       sign_in: 'login',
                       sign_out: 'logout',
                       edit: 'edit',
                     },
                     controllers: {
                       confirmations: 'confirmations',
                       masquerades: 'admin/masquerades',
                       registrations: 'users/registrations',
                       sessions: 'users/sessions'
                     } do
  end

  devise_scope :user do
    get 'confirmed', to: 'confirmations#confirmed'
  end

  mount GoodJob::Engine => 'good_job'

  # webhook endpoint for paddle service
  post 'paddle/hook'

  ## enduser endpoints
  # generic renders
  root to: 'pages#home'
  get 'thank-you', to: 'pages#thankyou'
  get '/creator', to: 'pages#creator'
  get '/pro', to: redirect('/plans')
  get '/pricing', to: redirect('/plans')
  get '/plans', to: 'pages#plans'
  get '/stats.txt', to: 'pages#stats'
  get '/example-email', to: 'pages#example'
  get '/500', to: 'errors#server_error'
  get '/422', to: 'errors#unacceptable'
  get '/404', to: 'errors#not_found'
  get '/feeds/export', to: 'feeds#export'
  get '/privacy-policy', to: 'pages#privacy_policy'
  get '/terms-of-service', to: 'pages#terms_of_service'

  ## more dynamic
  get 'subscribe/show'

  post 'import', to: 'import#create'
  get 'import', to: 'import#new'

  get 'unsubscribe', to: 'unsubscribe#destroy'

  get '/s/:slug', controller: :subscribe, action: :show
  post '/s/:slug', controller: :subscribe, action: :subscribe, as: :subscribe

  resources :feeds do
    get :check, on: :collection
    get :preview, on: :collection
  end

  # resources :announcements, only: [:index]
end
