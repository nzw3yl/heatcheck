class HeatHistoryWorker
  include Sidekiq::Worker
  
  def perform
   customers = Customer.all
    heat_log = HeatLog.where(['transaction_date > ?', DateTime.now - 30])
    measure = Measure.all
  
    customers.each do |customer|
      Array(1..12).each do |weeks_back|
        measure.each do |measure|
          max_temp = HeatLog.where(['transaction_date > ? AND transaction_date <= ? AND entity_type = ? AND entity_id = ? AND measure_id = ?', DateTime.now - weeks_back*7 - 7, DateTime.now - weeks_back*7, "Customer", customer.id, measure.id]).pluck("temperature").max || 1
          heat_history = HeatHistory.where(
            year: DateTime.now.year,
            week: DateTime.now.cweek - weeks_back,
            entity_type: "Customer",
            entity_id: customer.id).first_or_create
          heat_history.temperature = (heat_history.temperature || {}).merge(measure.content => max_temp)
          heat_history.save!
        end
      end  
    end
  end
end