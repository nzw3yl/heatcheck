require 'spec_helper'

describe "plans/edit" do
  before(:each) do
    @plan = assign(:plan, stub_model(Plan,
      :content => "MyString",
      :complete => false,
      :contact_id => 1,
      :issue => nil
    ))
  end

  it "renders the edit plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plan_path(@plan), "post" do
      assert_select "input#plan_content[name=?]", "plan[content]"
      assert_select "input#plan_complete[name=?]", "plan[complete]"
      assert_select "input#plan_contact_id[name=?]", "plan[contact_id]"
      assert_select "input#plan_issue[name=?]", "plan[issue]"
    end
  end
end
