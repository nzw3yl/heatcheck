require 'spec_helper'

describe "plans/new" do
  before(:each) do
    assign(:plan, stub_model(Plan,
      :content => "MyString",
      :complete => false,
      :contact_id => 1,
      :issue => nil
    ).as_new_record)
  end

  it "renders new plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", plans_path, "post" do
      assert_select "input#plan_content[name=?]", "plan[content]"
      assert_select "input#plan_complete[name=?]", "plan[complete]"
      assert_select "input#plan_contact_id[name=?]", "plan[contact_id]"
      assert_select "input#plan_issue[name=?]", "plan[issue]"
    end
  end
end
