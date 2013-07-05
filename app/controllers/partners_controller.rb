class PartnersController < ApplicationController
  before_filter :authenticate_user!
  # GET /partners
  # GET /partners.json
  def index
    if params[:term]
      @partners = Partner.scoped.order(:name).where("name ILIKE ?", "%#{params[:term]}%")
    else
      @partners = Partner.scoped
    end
    @partner = Partner.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @partners.map(&:name) }
    end
  end

  # GET /partners/1
  # GET /partners/1.json
  def show
    @partner = Partner.find(params[:id])
    @issueable = @partner
    @issues = @issueable.issues
    @issue = Issue.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partner }
    end
  end

  # GET /partners/new
  # GET /partners/new.json
  def new
    @parent_id = params[:parent_id] #|| default_parent.id
    @partner = Partner.new
    @partner.parent_id = @parent_id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @partner }
      format.js
    end
  end

  # GET /partners/1/edit
  def edit
    @partner = Partner.find(params[:id])
  end

  # POST /partners
  # POST /partners.json
  def create
    @partner = Partner.new(params[:partner])

    respond_to do |format|
      if @partner.save
        format.html { redirect_to @partner, notice: 'Partner was successfully created.' }
        format.json { render json: @partner, status: :created, location: @partner }
      else
        format.html { render action: "new" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /partners/1
  # PUT /partners/1.json
  def update
    @partner = Partner.find(params[:id])

    respond_to do |format|
      if @partner.update_attributes(params[:partner])
        format.html { redirect_to @partner, notice: 'Partner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /partners/1
  # DELETE /partners/1.json
  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy

    respond_to do |format|
      format.html { redirect_to partners_url }
      format.json { head :no_content }
    end
  end
  
  def show_heat
     @partner = Partner.find(params[:id])
   end

   def show_contacts
     @partner = Partner.find(params[:id])
     @partners = @partner.contacts
     @contactable = @partner
   end

   def show_history
     @partner = Partner.find(params[:id])
     @issue_histories = IssueHistory.where(['issueable_type = ? AND issueable_id = ?', "Partner", @partner.id]).order('close_date desc')
   end
  
end
