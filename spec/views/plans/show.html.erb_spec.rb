require 'spec_helper'

describe "plans/show" do
  before(:each) do
    @plan = assign(:plan, stub_model(Plan,
      :content => "Content",
      :complete => false,
      :contact_id => 1,
      :issue => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Content/)
    rendered.should match(/false/)
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
