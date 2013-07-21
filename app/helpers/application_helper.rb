module ApplicationHelper
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  def attributize(string)
    string.downcase.tr(" ","_")
  end
  
  def measure_display(measure_name)
    measure_mask = "measure_by_"
    if measure_name.start_with?(measure_mask)
      measure_name.sub(/^#{measure_mask}/,'').tr("_"," ").titleize
    else
      measure_name.tr("_"," ").titleize
    end     
  end
  
  def resource_name
     :user
  end

  def resource
     @resource ||= User.new
  end

  def devise_mapping
     @devise_mapping ||= Devise.mappings[:user]
  end
  
  def temperature_to_integer(temp)
    Integer(temp)
    rescue Exception
      0
  end
  
  def numeric?(object)
    true if Float(object) rescue false
  end
  
  def temperature_button(temp, path = "#")
    if numeric?(temp)
       temp = Integer(temp) 
     end  
    case(temp)
       when 1
         @btn_class = "btn btn-success btn-mini"
         @icon_class = "icon-large icon-thumbs-up-alt"
       when 2
         @btn_class = "btn btn-warning btn-mini"
         @icon_class = "icon-large icon-flag-alt"
       when 3
         @btn_class = "btn btn-danger btn-mini"
         @icon_class = "icon-large icon-flag-alt"
       when 4
         @btn_class = "btn btn-danger btn-mini"
         @icon_class = "icon-large icon-warning-sign"
       else
         @btn_class = "btn btn-success btn-mini"
    		 @icon_class= "icon-question-sign icon-large" 
     end
     link_to(path, :class => @btn_class) do
       content_tag(:i, "", :class => @icon_class)
     end 

  end
  
  def heat_map_history_value(entity_type, entity_id, weeks_back, measure)
     @hmh = HeatHistory.where(['year = ? AND week = ? AND entity_type = ? AND entity_id = ?', DateTime.now.year, DateTime.now.cweek - weeks_back, entity_type, entity_id]).last
     if @hmh
       Integer(@hmh.send(attributize(measure)) || 1) 
     else
       1
     end 
  end
  
  def load_issueable
    resource, id = request.path.split('/')[1,2]
    @issueable_entity = resource.singularize.classify.constantize.find(id)
    @issueable_class = resource.singularize.classify.constantize.to_s
  end
 
end
