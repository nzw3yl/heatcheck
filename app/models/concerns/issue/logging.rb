class Issue
  module Logging
    extend ActiveSupport::Concern
  
    module ClassMethods
      def log_temp_change(loggable, action)
        issueable = loggable.issueable_type.constantize.find(loggable.issueable_id)
        heat_array = issueable.issues.where(['measure_id = ? AND id <> ?', loggable.measure_id, loggable.id]).pluck("temperature")
        new_heat = loggable.temperature || 0
        next_highest_heat = heat_array.compact.max || 0
        if ["update", "create"].include?(action) 
           max_heat = next_highest_heat > new_heat ? next_highest_heat : new_heat
        else # deleting
           max_heat = next_highest_heat
        end
        new_entry = HeatLog.new do |hl|
          hl.transaction_date = Time.now()
          hl.temperature = max_heat
          hl.entity_id = loggable.issueable_id
          hl.entity_type = loggable.issueable_type
          hl.measure_id = loggable.measure_id
        end
        new_entry.save!
      end
    end

  end
  
end