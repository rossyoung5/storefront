class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_admin_user
    unless user_signed_in? && current_user.admin
      redirect_to root_url, alert: "YOU...SHALL NOT...PASS (If you're an admin, sign in to access)"
    end
  end

end
