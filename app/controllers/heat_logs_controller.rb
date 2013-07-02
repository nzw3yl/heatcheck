class HeatLogsController < ApplicationController
  # GET /heat_logs
  # GET /heat_logs.json
  before_filter :authenticate_user!
  
  def index
    @heat_logs = HeatLog.page(params[:page]).per_page(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @heat_logs }
      format.js
    end
  end

  # GET /heat_logs/1
  # GET /heat_logs/1.json
  def show
    @heat_log = HeatLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @heat_log }
    end
  end

  # GET /heat_logs/new
  # GET /heat_logs/new.json
  def new
    @heat_log = HeatLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @heat_log }
    end
  end

  # GET /heat_logs/1/edit
  def edit
    @heat_log = HeatLog.find(params[:id])
  end

  # POST /heat_logs
  # POST /heat_logs.json
  def create
    @heat_log = HeatLog.new(params[:heat_log])

    respond_to do |format|
      if @heat_log.save
        format.html { redirect_to @heat_log, notice: 'Heat log was successfully created.' }
        format.json { render json: @heat_log, status: :created, location: @heat_log }
      else
        format.html { render action: "new" }
        format.json { render json: @heat_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /heat_logs/1
  # PUT /heat_logs/1.json
  def update
    @heat_log = HeatLog.find(params[:id])

    respond_to do |format|
      if @heat_log.update_attributes(params[:heat_log])
        format.html { redirect_to @heat_log, notice: 'Heat log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @heat_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heat_logs/1
  # DELETE /heat_logs/1.json
  def destroy
    @heat_log = HeatLog.find(params[:id])
    @heat_log.destroy

    respond_to do |format|
      format.html { redirect_to heat_logs_url }
      format.json { head :no_content }
    end
  end
end
