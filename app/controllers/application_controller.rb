class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message 
  end
  
  
  around_filter :scope_current_provider
  
  def current_provider
    if user_signed_in?
      Provider.find_by_id(current_user.provider_id) || Provider.find(ENV['DEMO_SITE_ID'])
    else
      Provider.find(ENV['DEMO_SITE_ID'])
    end
  end
  helper_method :current_provider
  
  def scope_current_provider
    Provider.current_id = current_provider.id
    yield
  ensure
    Provider.current_id = nil
  end
  
  def default_parent
    if current_provider
      Partner.where(:provider_id => current_provider.id).first_or_create(:name => current_provider.name)
    else
      return nil
    end
  end
  helper_method :default_parent
  
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
