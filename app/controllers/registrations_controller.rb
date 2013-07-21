class RegistrationsController < Devise::RegistrationsController 
  protected
  
  
  def after_inactive_sign_up_path_for(resource)
    # the page prelaunch visitors will see after they request an invitation 
    '/thankyou.html'
    # add path here for options to:
    # 1. create a new provider
    # 2. join an existing provider using a secret code
    # 3. join the demo provider as a reviewer 
  end
  
  def after_sign_up_path_for(resource)
  # the page new users will see after sign up (after launch, when no invitation is needed) 
    redirect_to root_path
  end 
end