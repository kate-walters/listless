class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def has_permission?(list)
    list.user == current_user || list.allowed_users.include?(current_user) || list.user.users_with_access.include?(current_user)
  end
  helper_method :has_permission?

  def you_have_access_to(list)
    list.allowed_users.include?(current_user) || list.user.users_with_access.include?(current_user)
  end
  helper_method :you_have_access_to

  def disable_nav
    @disable_nav = true
  end
end
