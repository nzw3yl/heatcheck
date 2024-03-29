require 'spec_helper'

describe "customers/index" do
  before(:each) do
    assign(:customers, [
      stub_model(Customer,
        :name => "Name",
        :description => "Description"
      ),
      stub_model(Customer,
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of customers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "input[type=?]", "submit"
  end
end
