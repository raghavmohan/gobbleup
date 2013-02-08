class ApplicationController < ActionController::Base
  protect_from_forgery
  def getLeftLinks
    @left_nav = ["users", "restaraunts"]
    return @left_nav
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
