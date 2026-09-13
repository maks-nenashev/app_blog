Rails.application.routes.draw do
  OLD_LOCALES = /pl|ru|uk|en|nl/

  # 301-редиректы со старых локалей на английские эквиваленты
  get '/:locale/*path', to: redirect('/%{path}'), constraints: { locale: OLD_LOCALES }
  get '/:locale', to: redirect('/'), constraints: { locale: OLD_LOCALES }

  # Авторизация
  devise_for :users
  
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end

  root to: "home#index"
  get '/' => 'home#index'

  namespace :admin do
    resources :users, only: %i[index edit create update destroy]
  end

  resources :articles do
    resources :tweets, only: %i[create destroy edit update]
    resources :comments, only: [:new, :create, :edit, :update, :destroy, :show]
  end

  resources :comments, except: %i[new] do
    resources :tweets, only: %i[create destroy edit update] 
  end

  get "portfolio", to: "portfolio#index"
  get 'gallery', to: 'gallery#index'

  resources :manuscripts, only: [:index]
  resource :contacts, only: [:new, :create, :show], path_names: { new: '' }
end