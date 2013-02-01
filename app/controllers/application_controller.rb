class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def getLeftLinks
    @left_nav = ["users", "restaraunts"]
    return @left_nav
  end
end
