Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  get '/' =>'home#index'   # Eto nuzno wsegda! 
  root to: "home#index"

  resources :articles do  #вложенный маршрут:
       resources :comments
  end #4 
    
    #get 'contacts' => 'contacts#new' only:[:create]
    resource :contacts#, only: [:new,:create], path_names: { :new => '' }
                                              #Etot code dla 'contacts' => 'contacts#new'
                                            # Chtoby "contacts#new" otkrywalsa w "contacts"

 # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

 # Defines the root path route ("/")
 # root "articles#index
end
