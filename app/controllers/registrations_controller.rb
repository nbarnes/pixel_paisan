
class RegistrationsController < Devise::RegistrationsController

  # rubocop:disable Style/MethodLength
  def create
    respond_to do |format|
      format.html do
        super
      end
      format.js do
        build_resource sign_up_params
        if resource.save
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_navigational_format?
            sign_up(resource_name, resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
            expire_session_data_after_sign_in!
          end
        else
          clean_up_passwords resource
        end
      end
    end
  end
  # rubocop:enable Style/MethodLength

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

end
