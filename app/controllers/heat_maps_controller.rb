class HeatMapsController < ApplicationController
  before_filter :authenticate_user!
  
  def update
    #HeatMapWorker.perform_async
    customers = Customer.where(:auto_temp => true).all
    measures = Measure.all
    max_heat = 0
    customers.each do |customer|
      measures.each do |measure|
        heat_array = customer.issues.where(:measure_id => measure.id).pluck("temperature")
        measure_heat = heat_array.compact.max || 0
        customer.send("#{measure.content.downcase.tr(" ","_")}=", measure_heat) 
        max_heat = measure_heat > max_heat ? measure_heat : max_heat
      end
      customer.temperature = max_heat || 0
      customer.save!
      max_heat = 0
    end
    
    partners = Partner.where(:auto_temp => true).all
    max_heat = 0
    partners.each do |partner|
      measures.each do |measure|
        heat_array = partner.issues.where(:measure_id => measure.id).pluck("temperature")
        # adding the customer heat check to the partner level
        partner.customers.each do |partner_customer|
          partner_customer_value = partner_customer.send("#{measure.content.downcase.tr(" ","_")}")
          partner_customer_value.nil? ? 0 : Integer(partner_customer_value)
          heat_array << partner_customer_value
        end
        measure_heat = heat_array.map(&:to_i).compact.max || 0
        partner.send("#{measure.content.downcase.tr(" ","_")}=", measure_heat)
        max_heat = measure_heat > max_heat ? measure_heat : max_heat
      end
      partner.temperature = max_heat || 0
      partner.save!
      max_heat = 0
    end
    respond_to do |format|
       format.html { redirect_to root_path }
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
