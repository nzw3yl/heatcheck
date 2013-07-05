module PartnersHelper

  
  def nested_partners(partners)
    partners.map do |partner, sub_partner|
      render(partner) + content_tag(:div, nested_partners(sub_partner), :class => "nested_items")
    end.join.html_safe
  end
end
