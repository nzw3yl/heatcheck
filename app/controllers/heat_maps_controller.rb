class HeatMapsController < ApplicationController

  def update
    @customers = Customer.where(:auto_temp => true).all
    @measures = Measure.all
    max_heat = 0
    @customers.each do |customer|
      @measures.each do |measure|
        heat_array = customer.issues.where(:measure_id => measure.id).pluck("temperature")
        measure_heat = heat_array.compact.max || 0
        customer.send("#{measure.content.downcase}=", measure_heat)  if heat_array
        max_heat = measure_heat > max_heat ? measure_heat : max_heat
      end
      customer.temperature = max_heat || 0
      customer.save!
      max_heat = 0
    end
    
    
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
end