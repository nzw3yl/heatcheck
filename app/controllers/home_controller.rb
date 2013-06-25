class HomeController < ApplicationController
  layout :home_layout
  
  def index
  end
  
  
private
  def home_layout
    user_signed_in? ? "application" : "splash"
  end
end
