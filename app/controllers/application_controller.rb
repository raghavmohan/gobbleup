class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :resolve_layout

  def getLeftLinks
    @left_nav = ["users", "restaraunts"]
    return @left_nav
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user




  def resolve_layout
    case action_name
    when "login"
      "login"
    else
      "application"
    end
  end
end
