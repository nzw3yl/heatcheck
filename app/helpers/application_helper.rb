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
  
  def temperature_button(temp, path = "#")
    case(temp)
       when 0
         @btn_class = "btn btn-success btn-mini"
         @icon_class = "icon-large icon-thumbs-up-alt"
       when 1
         @btn_class = "btn btn-success btn-mini"
         @icon_class = "icon-large icon-thumbs-up-alt"
       when 2
         @btn_class = "btn btn-warning btn-mini"
         @icon_class = "icon-large icon-flag-alt"
       when 3
         @btn_class = "btn btn-danger btn-mini"
         @icon_class = "icon-large icon-flag-alt"
       else
         @btn_class = "btn btn-danger btn-mini"
    		 @icon_class= "icon-warning-sign icon-large" 
     end
     link_to(path, :class => @btn_class) do
       content_tag(:i, "", :class => @icon_class)
     end 

  end
end
