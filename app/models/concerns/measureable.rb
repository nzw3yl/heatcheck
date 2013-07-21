module Measureable
  extend ActiveSupport::Concern
  
  instance_methods.each do |m|
    undef_method m unless m._to_s =~ /^__|method_missing|respond_to?|respond_to_missing?/
  end
  
  def method_missing(method_sym, *args)
   #super if !respond_to?(measure)
    method_string = method_sym.to_s
    if method_string =~ (/=$/)
      method_setter = true
      method_name = method_string.chop
    else
      method_setter = false
      method_name = method_string
    end
    
    if  Measure.pluck(:content).collect{|mes| mes.tr(" ","_").downcase}.include?(method_name)
      if method_setter
        if has_attribute?(:current_heatmap)
         self.current_heatmap = (current_heatmap || {}).merge(method_name => args.first)
       else
         self.temperature = (temperature || {}).merge(method_name => args.first)
       end
      else
        if has_attribute?(:current_heatmap)
          current_heatmap && current_heatmap[method_name] 
        else
          temperature && temperature[method_name] 
        end
      end
    else
      super
    end
  end
  
  def respond_to_missing?(measure, include_private = false)
    method_name = measure.to_s
    Measure.pluck(:content).collect{|mes| mes.tr(" ","_").downcase}.include?(method_name) || super
  end
   
  # #included do
  # 
  #   #Measure.pluck(:content).map(&:downcase).each do |key|
  #    Measure.pluck(:content).map(&:downcase).each do |key|
  #         attr_accessible key
  #         scope "has_#{key}", lambda { |value| where("current_heatmap @> (? => ?)", key, value) }
  # 
  #       define_method(key) do
  #         current_heatmap && current_heatmap[key]
  #       end
  # 
  #       define_method("#{key}=") do |value|
  #         self.current_heatmap = (current_heatmap || {}).merge(key => value)
  #       end
  #     end
  # 
  # end
end