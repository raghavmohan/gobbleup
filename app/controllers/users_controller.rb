class UsersController < ApplicationController
  # GET /users
  # GET /users.json

  ## This should be in Application Controller...
  @@fburl = "https://graph.facebook.com/"
  @@authkey = "AIzaSyADf-Tno7s-r5aU0hY6-KDC2wapw8iKa4U"
  @@gmapsurl = "https://maps.googleapis.com/maps/api/place/search/json?location="
  @@client_id = "131364997031342"
  @@client_secret = "44c516fb668a71852347686ec508cbef" 
  @@fbaccess_token =""
  require 'open-uri'


  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def login
    if current_user != nil
      redirect_to :controller=>"users", :action=>"show", :id => current_user.id
    end
  end

  def show_restaraunt
    unless params[:fbid].nil?
      fbid=params[:fbid]
    end
    about = JSON.parse(open(URI::escape(@@fburl+fbid)).read)
    if(about["website"].nil?)
      if(about["link"] != nil)
        redirect_to(about["link"]) 
      else
        redirect_to :root
      end
    else
      about["website"] = about["website"].gsub(/http:\/\//, "")
      redirect_to(URI::escape("http://"+about["website"]))
    end
  end


  def getUserFriends(user)
    if user == nil
      return user
    else
      user.friends=JSON.parse(open(URI::escape(@@fburl+current_user.uid+"?fields=id,name,friends&access_token="+current_user.oauth_token)).read)["friends"]["data"]
    end
    return user
  end

  def getFriends
    if current_user==nil
      redirect_to :root
    else 
      current_user.friends=JSON.parse(open(URI::escape(@@fburl+current_user.uid+"?fields=id,name,friends&access_token="+current_user.oauth_token)).read)["friends"]["data"]
    end
  end

  def getLocations
    @lat = "43.074955443048"
    @long = "-89.396645675076"
    @radius = "1000"
    @limit = "10"
    @genre = "mexican"
    unless params[:lat].nil?
      @lat = params[:lat]
    end
    unless params[:long].nil?
      @long = params[:long]
    end
    unless params[:radius].nil?
      @radius = params[:radius]
    end
    unless params[:limit].nil?
      @limit = params[:limit]
    end
    unless params[:genre].nil? or params[:genre].downcase == ""
      @genre = params[:genre]
    end
    fbtokenurl = @@fburl+"oauth/access_token?client_id="+@@client_id+"&client_secret="+@@client_secret+"&grant_type=client_credentials"
    @@fbaccess_token = open(URI::escape(fbtokenurl)).read
    @fbmapsurl = "https://graph.facebook.com/search?q=#{@genre}&type=place&"+@@fbaccess_token+"&center="+@lat+","+@long+"&distance="+@radius+"&limit="+@limit

    @restarauntsData = JSON.parse(open(URI::escape(@fbmapsurl)).read)
    @restarauntsData = @restarauntsData["data"]

    @restarauntsData.each do |restaraunt|
      restaraunt["fb_pic"] = URI::escape(@@fburl+restaraunt["id"]+"/picture?type=large")
      restaraunt["fb_pic_logo"] = URI::escape(@@fburl+restaraunt["id"]+"/picture?type=square")
      if restaraunt["website"].nil?
        restaraunt["website"] = "#"
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    if @user.phone_number != nil

      @user = getUserFriends(@user)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to :action=>:edit, :id => @user.id
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end


end
