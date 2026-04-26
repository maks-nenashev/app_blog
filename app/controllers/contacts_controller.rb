class ContactsController < ApplicationController
    #def show
     # @contact = Contact.find(params[:id])
    #end
    
   
   def new  #создать - new (отобразить форму. GET)
        @contact = Contact.new  # Пустым оставлять тельзя!
     end
   
            
     def create  #create (отправить форму. POST)   
        @contact = Contact.new(contact_params)
     if @contact.valid?  # walidacija
        @contact.save
        #redirect_to @contact
      else
        render action: 'new' # Esli forma ne walidna to idet wozwrat na stranicu "new"
       end
     end
     
     private
   
     def contact_params
       params.require(:contact).permit(:email,:text)
     end
     
end

