
module EditorHelper

  def has_logged_in_user
    return current_user.nil? ? 0 : 1
  end

end
