class MembershipsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @members = User.all(:joins => {:provider => :memberships}, :conditions => {:memberships => {:provider_id => current_provider.id}}).uniq
  end
end