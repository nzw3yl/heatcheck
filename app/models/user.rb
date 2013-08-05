class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  attr_accessible :role_ids, :as => :admin
  
  after_create :send_welcome_email
  # attr_accessible :title, :body
  has_many :memberships
  has_many :providers, through: :memberships
  has_many :invites
  belongs_to :provider
  
  before_create :set_provider_id
  after_create :add_membership

  #validates_presence_of :first_name, :last_name
  validates_confirmation_of :password
  
  # def password_required? 
  #     if !persisted?
  #       !(password != "") 
  #     else
  #       !password.nil? || !password_confirmation.nil?
  #     end 
  #   end
  #   
  #   # override Devise method
  #   def confirmation_required? 
  #     false
  #   end
  #   
  #   # override Devise method
  #   def active_for_authentication?
  #     confirmed? || confirmation_period_valid?
  #   end
  
  def send_reset_password_instructions 
    if self.confirmed?
      super 
    else
      errors.add :base, "You must receive an invitation before you set your password." 
    end
  end
  
  def validate_invitation(invitation_code)
    @invite = Invite.find_by_invitee_email_and_access_code(self.email, invitation_code)
    if @invite
      @invite.accept!
      self.provider_id = @invite.provider_id
      self.save
    end
  end

  def switch_provider!(new_provider)
    if self.memberships.pluck(:provider_id).include?(new_provider)
      self.provider_id = new_provider 
      self.save
    else
      self.provider_id = ENV['DEMO_SITE_ID']
      self.save
      return false
    end

  end

  private
    def set_provider_id
      self.provider_id = ENV['DEMO_SITE_ID'] if provider_id.blank?
    end
    
    def add_membership
      Membership.where(:provider_id => provider_id, :user_id => id).first_or_create
    end
    
    def send_welcome_email
      self.add_role :limbo
      return if email.include?(ENV['ADMIN_EMAIL']) 
      UserMailer.welcome_email(self).deliver
    end
end
