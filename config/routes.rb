Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do #Podkluchenie Perewoda
#///////////////////////////////////////////////////////////////////////////
   # Awtoruzacija
devise_for :users
  
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
 #/////////////////////////////////////////////////////////////////////////// 
 root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #root :to => 'somecontroller#index'
  get '/' =>'home#index'   # Eto nuzno wsegda! 
  
  namespace :admin do #Импорт/экспорт Excel, архивы ZIP
      resources :users, only: %i[index edit create update destroy]
  end
  
  resources :articles do  #вложенный маршрут:
    resources :tweets, only: %i[create destroy] #
    resources :comments #, except: %i[new show] # Wse marшруты нужны кроме [ new show]
       
  end #4 
  
  resources :comments, except: %i[new show] do  #вложенный маршрут:
      resources :tweets, only: %i[create destroy]
  end
    #get 'contacts' => 'contacts#new' only:[:create]
    resource :contacts, only: [:new,:create,:show], path_names: { :new => '' }
                                              #Etot code dla 'contacts' => 'contacts#new'
                                            # Chtoby "contacts#new" otkrywalsa w "contacts"

 # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
   end
 # Defines the root path route ("/")
 # root "articles#index
end
