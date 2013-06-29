module CustomersHelper
  def default_parent
    if current_provider
      Customer.where(:provider_id => current_provider.id).first_or_create(:name => current_provider.name)
    else
      return nil
    end
  end
  
  def nested_customers(customers)
    customers.map do |customer, sub_customer|
      render(customer) + content_tag(:div, nested_customers(sub_customer), :class => "nested_items")
    end.join.html_safe
  end
  

end

