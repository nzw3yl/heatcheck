class IssuesController < ApplicationController
  before_filter :load_issueable
  before_filter :authenticate_user!
  
  def index
    #@issueable = Customer.find(params[:customer_id])
    @issues = @issueable.issues
  end

  def show
    @issue = @issueable.issues.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  def new
    @issue = @issueable.issues.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
      format.js
    end
  end
  
  def edit
    @issue = @issueable.issues.find(params[:id])
  end
  
  def update
    @issue = @issueable.issues.find(params[:id])
    
    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        Issue.log_temp_change(@issue, params[:action])
        format.html { redirect_to @issueable, notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @issue = @issueable.issues.new(params[:issue])
    if @issue.save
      Issue.log_temp_change(@issue, params[:action])
      redirect_to @issueable, notice: "issue created."
    else
      render :new
    end
  end
  
  def destroy
     @issue = Issue.find(params[:id])
     Issue.log_temp_change(@issue, params[:action])
     @issue.destroy
     
     respond_to do |format|
       format.html
       format.json { head :no_content }
       format.js
     end
   end
  
  private
    def load_issueable
      resource, id = request.path.split('/')[1,2]
      @issueable = resource.singularize.classify.constantize.find(id)
    end
    
    def load_issueable_v2
      klass =[Customer, Partner].detect {|i| params["#{i.name.underscore}_id"]}
      @issueable = klass.find(params["#{klass.name.underscore}_id"])
    end
end
