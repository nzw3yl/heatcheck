require 'spec_helper'

describe "invites/new" do
  before(:each) do
    assign(:invite, stub_model(Invite,
      :user_id => 1,
      :provider_id => 1,
      :invitee_email => "MyString",
      :access_code => "MyString",
      :accepted => false
    ).as_new_record)
  end

  it "renders new invite form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", invites_path, "post" do
      assert_select "input#invite_user_id[name=?]", "invite[user_id]"
      assert_select "input#invite_provider_id[name=?]", "invite[provider_id]"
      assert_select "input#invite_invitee_email[name=?]", "invite[invitee_email]"
      assert_select "input#invite_access_code[name=?]", "invite[access_code]"
      assert_select "input#invite_accepted[name=?]", "invite[accepted]"
    end
  end
end
