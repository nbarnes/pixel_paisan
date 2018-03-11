class SessionsController < Devise::SessionsController

  respond_to :json

  # rubocop:disable Metrics/MethodLength
  def create
    respond_to do |format|
      format.html do
        super
      end
      format.json do
        resource = User.find_for_database_authentication(email: params[:email])
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:password])
          sign_in :user, resource
          render json: {
            message: 'Login success',
            status: 200
          }, status: 200
          return
        end

        invalid_login_attempt
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    render json: flash[:alert], status: 401
  end

end
