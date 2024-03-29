class HeatMapWorker
  include Sidekiq::Worker
  
  
  def perform
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
        measure_heat = heat_array.compact.max || 0
        partner.send("#{measure.content.downcase.tr(" ","_")}=", measure_heat) 
        max_heat = measure_heat > max_heat ? measure_heat : max_heat
      end
      partner.temperature = max_heat || 0
      partner.save!
      max_heat = 0
    end
    
  end
  
end