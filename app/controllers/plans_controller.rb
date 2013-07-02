class PlansController < ApplicationController
  before_filter :load_issue
  before_filter :authenticate_user!
  
  # GET /plans
  # GET /plans.json
  def index
    @incomplete_plans = @issue.plans.where(complete: false)
    @complete_plans = @issue.plans.where(complete: true)
    @owner_name = issue_owner.name
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    @plan = Plan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/new
  # GET /plans/new.json
  def new
    @plan = @issue.plans.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan }
      format.js
    end
  end

  # GET /plans/1/edit
  def edit
    @plan = Plan.find(params[:id])
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = @issue.plans.new(params[:plan])

    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render json: @plan, status: :created, location: @plan }
        format.js 
      else
        format.html { render action: "new" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plans/1
  # PUT /plans/1.json
  def update
    @plan = Plan.find(params[:id])
    @issue = Issue.find_by_id(@plan.issue_id)
    
    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        format.html { redirect_to issue_plans_url(@issue), notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan = Plan.find(params[:id])
    @issue = Issue.find_by_id(@plan.issue_id)
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to issue_plans_url(@issue) }
      format.json { head :no_content }
      format.js
    end
  end
  
  
private
  def load_issue
    if params[:issue_id]
      @issue = Issue.find_by_id(params[:issue_id])
    end
  end
  
  def issue_owner
    klass =[Customer, Partner].detect {|i| params["#{i.name.underscore}_id"]}
    klass.find(params["#{klass.name.underscore}_id"])
  end
end
