class InvitesController < ApplicationController
  before_filter :authenticate_user!
  require 'securerandom'
  # GET /invites
  # GET /invites.json
  def index
    @invites = Invite.where(:accepted => false).order(:invitee_email).joins(:user).select("invites.*, users.first_name as first_name, users.last_name as last_name")
    @invite = current_provider.invites.build
    @invite.access_code = suggest_access_code
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invites }
    end
  end

  # GET /invites/1
  # GET /invites/1.json
  def show
    @invite = Invite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invite }
    end
  end

  # GET /invites/new
  # GET /invites/new.json
  def new
    @invite = Invite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invite }
    end
  end

  # GET /invites/1/edit
  def edit
    @invite = Invite.find(params[:id])
  end

  # POST /invites
  # POST /invites.json
  def create
    # code smell
    params[:invite][:provider_id] = current_provider.id
    params[:invite][:user_id] = current_user.id
    params[:invite][:accepted] = false
    @invite = Invite.new(params[:invite])


    respond_to do |format|
      if @invite.save
        format.html { redirect_to @invite, notice: 'Invite was successfully created.' }
        format.json { render json: @invite, status: :created, location: @invite }
      else
        format.html { render action: "new" }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invites/1
  # PUT /invites/1.json
  def update
    @invite = Invite.find(params[:id])

    respond_to do |format|
      if @invite.update_attributes(params[:invite])
        format.html { redirect_to @invite, notice: 'Invite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invites/1
  # DELETE /invites/1.json
  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    respond_to do |format|
      format.html { redirect_to invites_url }
      format.json { head :no_content }
    end
  end
  
  
  private
    def suggest_access_code
      SecureRandom.hex(12).upcase[0..7]
    end
end
