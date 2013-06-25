class ApplicationController < ActionController::Base
  protect_from_forgery
  
  around_filter :scope_current_provider
  
  def current_provider
    if user_signed_in?
      Provider.find_by_id(current_user.provider_id)
    else
      Provider.find(1)
    end
  end
  helper_method :current_provider
  
  def scope_current_provider
    Provider.current_id = current_provider.id
    yield
  ensure
    Provider.current_id = nil
  end
  
  
  
  def temp_status(temp)
    case(temp)
      when 0
        "-none"
      when 1
        "-success" #green
      when 2
        ""  #warning - yellow
      when 3
        "-error" #red
      else
        "-error" #inferno
    end
         
  end
  helper_method :temp_status
end
