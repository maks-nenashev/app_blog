Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
  root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #root :to => 'somecontroller#index'
  get '/' =>'home#index'   # Eto nuzno wsegda! 
  

  resources :articles do  #вложенный маршрут:
       resources :comments #, except: %i[new show] # Wse marшруты нужны кроме [ new show]
  end #4 
    
    #get 'contacts' => 'contacts#new' only:[:create]
    resource :contacts, only: [:new,:create,:show], path_names: { :new => '' }
                                              #Etot code dla 'contacts' => 'contacts#new'
                                            # Chtoby "contacts#new" otkrywalsa w "contacts"

 # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

 # Defines the root path route ("/")
 # root "articles#index
end
