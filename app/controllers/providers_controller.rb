class ProvidersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => :show
  # GET /providers
  # GET /providers.json
  def index
    @providers = Provider.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    if has_membership?(params[:id].to_i)
      @provider = Provider.find(params[:id])
    else
      @provider = current_provider
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.json
  def new
    @provider = Provider.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @provider }
    end
  end

  # GET /providers/1/edit
  def edit
    @provider = current_provider #Provider.find(params[:id])
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(params[:provider])

    respond_to do |format|
      if params[:creator_id] != current_user.id && @provider.save
        format.html { redirect_to @provider, notice: 'Provider was successfully created.' }
        format.json { render json: @provider, status: :created, location: @provider }
      else
        format.html { render action: "new" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.json
  def update
    @provider = current_provider # Provider.find(params[:id])

    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        format.html { redirect_to @provider, notice: 'Provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider = current_provider # Provider.find(params[:id])
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url }
      format.json { head :no_content }
    end
  end
  
  def issues
    @customer_issues = []
    @partner_issues = []
    @provider = current_provider
    @customers = @provider.customers
    @customers.each do |customer|
      customer.issues.each do |issue|
        @customer_issues << issue
      end
    end
    @partners = @provider.partners
    @partners.each do |partner|
      partner.issues.each do |issue|
        @partner_issues << issue
      end
    end
  end
  
  def plans
    @provider = current_provider
    @plans = Plan.order("contacts.name").joins(:contact).select("plans.*, contacts.name as contact_name")
  end
  
  def switch
    @new_provider = params[:new_provider]
    
    respond_to do |format|
      if current_user.switch_provider!(@new_provider.to_i)
        format.html { redirect_to root_path, notice: 'Changed to new service provider successfully.' }
        format.json { head :no_content }
      else
        flash.now[:warning] = "Now using the demonstration site. "
        format.html { render lobbies_show_path }
        format.json { head :no_content }
      end
    end
  end
  
  def has_membership?(provider_id)
    
    current_user.memberships.pluck(:provider_id).include?(provider_id)
  end
  
end
