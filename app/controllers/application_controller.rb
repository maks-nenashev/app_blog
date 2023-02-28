class ApplicationController < ActionController::Base
  include Pagy::Backend   #Podkluczenie "Pagy"
  include ErrorHandling # Podkluczenie ERORR 404
          
                     # gem "devase"
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
#//////////////////////////////////////////////////////////////////////////////////////
    
             #Podkluchenie perewoda
around_action :switch_locale

    private
    
    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale locale, &action 
    end

    def locale_form_url
      locale = params[:locale]
      return locale if I18n.available_locales.map(&:to_s).include?(locale)
      nil
    end
    
    def default_url_options
    {locale:I18n.locale}
    end
end
          
    
      



