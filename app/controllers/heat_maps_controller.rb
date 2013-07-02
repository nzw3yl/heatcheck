class HeatMapsController < ApplicationController
  before_filter :authenticate_user!
  
  def update
    HeatMapWorker.perform_async
    respond_to do |format|
       format.html { redirect_to sidekiq_web_path }
       format.json { head :no_content }
     end
  end
  
  def history
   HeatHistoryWorker.perform_async
   respond_to do |format|
      format.html { redirect_to sidekiq_web_path }
      format.json { head :no_content }
    end
  end

end
