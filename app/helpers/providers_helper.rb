module ProvidersHelper
  def get_issue_path(issue_id)
    @issue = Issue.find_by_id(issue_id)
    if @issue
      if @issue.issueable_type == "Customer"
        customer_issue_plans_path(Customer.find_by_id(@issue.issueable_id), issue_id)
      elsif @issue.issueable_type == "Partner"
        partner_issue_plans_path(Partner.find_by_id(@issue.issueable_id), issue_id)
      else
        "#"
      end
    else
      "#"
    end
  end
end
