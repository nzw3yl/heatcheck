class IssuesController < ApplicationController
  before_filter :load_issueable
  
  def index
    #@issueable = Customer.find(params[:customer_id])
    @issues = @issueable.issues
  end

  def show
    @issue = Issue.find(params[:id])
    
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

  def create
    @issue = @issueable.issues.new(params[:issue])
    if @issue.save
      redirect_to @issueable, notice: "issue created."
    else
      render :new
    end
  end
  
  def destroy
     @issue = Issue.find(params[:id])
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
