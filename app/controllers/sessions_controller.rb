class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    #redirect_to :controller=>"users", :action=>"show", :id => user.id
    if user.phone_number == nil
      redirect_to :controller=>"users", :action=>"edit", :id => user.id
    else
      redirect_to :controller=>"users", :action=>"show", :id => user.id
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
