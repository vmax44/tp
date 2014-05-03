class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
    before_action :set_locale
  
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password,:login, :remember_me) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation,:login, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation,:login,:firstname,:lastname,:ikp,:current_password) }
    end
  
    def validator(object)
      object.valid?
      model = object.class.name.underscore.to_sym
      field = params[model].first[0]
      @errors = object.errors[field]

      if @errors.empty?
        @errors = true
      else
        name = t("activerecord.attributes.#{model}.#{field}")
        @errors.map! { |e| "#{name} #{e}<br />" }
      end
    end
    

    def set_locale
      if user_signed_in? 
        I18n.locale = current_user.locale || I18n.default_locale
      end
    end
    
  end
