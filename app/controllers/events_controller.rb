class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  require 'open-uri'

  @@fburl="https://graph.facebook.com/"
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    if current_user == nil
      redirect_to root
    else
      @event = Event.new
      @event.creator_id = current_user.id
      @potential_users = current_user.getFriends
      @checkbox = [[]]
=begin
      t = User.first
      @potential_users.each do |u|
        unless u["name"].nil?
          @checkbox << ['<img src="https://graph.facebook.com/'+u["id"]+'/picture"/>'+u["name"], t.id]
        end 
      end
      @checkbox.shift
=end
      @potential_users.each do |u|
        t = User.where("uid"=>u["id"]).first
        unless t.nil?
          @checkbox << ['<img src="https://graph.facebook.com/'+u["id"]+'/picture">'+u["name"], t.id]
        end
      end

      @checkbox.shift
      @location = []
      unless params[:fbid].nil?
        @fblocurl = URI::escape(@@fburl+params[:fbid]+"")
        @location = JSON.parse(open(URI::escape(@@fburl+params[:fbid]+"")).read)
      end

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @event }
      end
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end


  def split_message(message)
    return message.scan /.{150}/
  end

  # POST /events
  # POST /events.json
  def create
    if current_user == nil
      redirect_to root
    else
      @event = Event.new(params[:event])
      @event.creator = current_user
      respond_to do |format|
        if @event.save
          message = current_user.name+" has invited you, "
          cu_message = "You invited "
          @event.users.each do |u|
            message += u.name+", "
            cu_message += u.name+", "
          end
          message += "to join them at "+@event.location+"!"
          cu_message += "to join you at "+@event.location+"!"
          @event.users.each do |u|
            PhoneGateway.send_text_message(u.phone_number, message)
            #spm = split_message(message)
            #spm.each do |m|
            #  PhoneGateway.send_text_message(u.phone_number, m)
            #end
          end
          PhoneGateway.send_text_message(current_user.phone_number, cu_message)
          #spmcu = split_message(cu_message)
          #spmcu.each do |m|
          #  PhoneGateway.send_text_message(current_user.phone_number, m)
          #end
          #PhoneGateway.send_text_message(current_user.phone_number, cu_message)
          format.html { 
            redirect_to current_user 
            flash[:notice] = 'Event was successfully created.'
          }
          #format.html { redirect_to @event, notice: 'Event was successfully created.' }
          format.json { render json: @event, status: :created, location: @event }
        else
          format.html { render action: "new" }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
