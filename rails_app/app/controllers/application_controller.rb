# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :configure_permitted_devise_parameters, if: :devise_controller?

    def configure_permitted_devise_parameters
        devise_parameter_sanitizer.permit(:account_update, keys: [:favorite_currency_code])
    end

    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource_or_scope)
        # if resource_or_scope == :user
            
        # else
        root_path
    end

end
