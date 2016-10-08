
module EditorHelper

  def user_logged_in?
    return current_user.nil? ? 0 : 1
  end

end
