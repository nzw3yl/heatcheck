module CustomersHelper
  def default_parent
    if current_provider
      Customer.where(:provider_id => current_provider.id).first_or_create(:name => current_provider.name)
    else
      return nil
    end
  end

  
  def start_of_weeks_back_date(num)
    Date.commercial(Date.today.year,Date.today.cweek - num,1).month.to_s + "/" + Date.commercial(Date.today.year,Date.today.cweek - num,1).day.to_s
  end
end

