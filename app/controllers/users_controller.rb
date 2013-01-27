class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    require 'open-uri'
    require 'json'
    @users = User.all


    @authkey = "AIzaSyADf-Tno7s-r5aU0hY6-KDC2wapw8iKa4U"
    @mapsurl = "https://maps.googleapis.com/maps/api/place/search/json?location="
    @restarauntsData = JSON.parse(open(@mapsurl+params[:lat]+","+params[:long]+"&radius="+params[:radius]+"&key="+@authkey+"&sensor=true").read)

 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
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

  def getNearbyRestaraunts
    @authkey = "AIzaSyADf-Tno7s-r5aU0hY6-KDC2wapw8iKa4U"
    @mapsurl = "https://maps.googleapis.com/maps/api/place/search/json?location="
    @restarauntsData = JSON.parse(open(@mapsurl+params[:lat]+","+params[:long]+"&radius="+params[:radius]+"&key="+@authkey+"&sensor=true").read)

  end


end
