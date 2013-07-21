require 'spec_helper'

describe "invites/index" do
  before(:each) do
    assign(:invites, [
      stub_model(Invite,
        :user_id => 1,
        :provider_id => 2,
        :invitee_email => "Invitee Email",
        :access_code => "Access Code",
        :accepted => false
      ),
      stub_model(Invite,
        :user_id => 1,
        :provider_id => 2,
        :invitee_email => "Invitee Email",
        :access_code => "Access Code",
        :accepted => false
      )
    ])
  end

  it "renders a list of invites" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Invitee Email".to_s, :count => 2
    assert_select "tr>td", :text => "Access Code".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
