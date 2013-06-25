module IssuesHelper
  def measure_name(id)
    @measure = Measure.find_by_id(id)
    @measure.nil? ? "unknown" : @measure.content
  end
  
  def temp_indicator(temp)
    case(temp)
      when 0
        content_tag(:span, temp, :class => "badge")
      when 1
        content_tag(:span, temp, :class => "badge badge-success") #green
      when 2
        content_tag(:span, temp, :class => "badge badge-warning")  #warning - yellow
      when 3
        content_tag(:span, temp, :class => "badge badge-important") #red
      else
        content_tag(:span, temp, :class => "badge badge-important") #inferno
    end
  end
  
end
