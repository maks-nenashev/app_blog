module Authorization
    extend ActiveSupport::Concern
  
    included do
      include Pundit
  
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
      private
  
      def user_not_authorized
        flash[:danger] = 'global.flash.not_authorized'
        #redirect_back(fallback_location: root_path)
        redirect_to(request.referer || root_path)
      end
    end
  end