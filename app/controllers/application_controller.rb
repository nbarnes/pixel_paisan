class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'layouts/user'

  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_palettes
    palettes = Palette.where(is_default: true)
    palettes.concat Palette.where(user_id: current_user.id) if user_signed_in?
    return palettes
  end

  protected

    def configure_permitted_parameters
      added_attrs = %i[name email password password_confirmation remember_me]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

  private
    def admin_authorize
      redirect_to root_path unless current_user && current_user.admin?
    end

end
