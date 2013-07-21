require 'spec_helper'

describe "invites/show" do
  before(:each) do
    @invite = assign(:invite, stub_model(Invite,
      :user_id => 1,
      :provider_id => 2,
      :invitee_email => "Invitee Email",
      :access_code => "Access Code",
      :accepted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Invitee Email/)
    rendered.should match(/Access Code/)
    rendered.should match(/false/)
  end
end
