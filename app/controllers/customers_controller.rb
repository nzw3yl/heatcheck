class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.json
  before_filter :authenticate_user!
  
  def index
    if params[:term]
      @customers = Customer.scoped.order(:name).where("name ILIKE ?", "%#{params[:term]}%")
    else
      @customers = Customer.scoped
    end
    @customer = Customer.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers.map(&:name) }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])
    @issueable = @customer
    @issues = @issueable.issues
    @issue = Issue.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @parent_id = params[:parent_id] #|| default_parent.id
    @customer = Customer.new
    @customer.parent_id = @parent_id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
      format.js
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end
  
  def show_heat
    @customer = Customer.find(params[:id])
  end
  
  def show_contacts
    @customer = Customer.find(params[:id])
    @contacts = @customer.contacts
    @contactable = @customer
  end
 
  def show_history
    @customer = Customer.find(params[:id])
    @issue_histories = IssueHistory.where(['issueable_type = ? AND issueable_id = ?', "Customer", @customer.id]).order('close_date desc')
  end

end
