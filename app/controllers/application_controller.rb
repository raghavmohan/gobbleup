class ApplicationController < ActionController::Base
  protect_from_forgery



  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  
  def getLeftLinks
    @left_nav = ["users", "restaraunts"]
    return @left_nav
  end
end
