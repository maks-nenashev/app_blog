class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling
  include Pundit::Authorization

  before_action :set_locale

  # ... Devise config (оставь как есть)
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end

  private
  
  def set_locale
     I18n.locale = :en
  end
  # stop using local
  # def set_locale  
  #   I18n.locale =
  #     params[:locale] ||
  #     session[:locale] ||
  #     extract_locale_from_accept_language_header ||
  #     I18n.default_locale
  #   session[:locale] = I18n.locale
  # end

  def extract_locale_from_accept_language_header
    http_langs = request.env['HTTP_ACCEPT_LANGUAGE']
    return nil unless http_langs

    browser_locales = http_langs.scan(/[a-z]{2}/)
    available = I18n.available_locales.map(&:to_s)
    browser_locales.find { |locale| available.include?(locale) }
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
