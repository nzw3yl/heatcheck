module PartnersHelper
  def default_parent
    if current_provider
      Partner.where(:provider_id => current_provider.id).first_or_create(:name => current_provider.name)
    else
      return nil
    end
  end
  def nested_partners(partners)
    partners.map do |partner, sub_partner|
      render(partner) + content_tag(:div, nested_partners(sub_partner), :class => "nested_items")
    end.join.html_safe
  end
end
