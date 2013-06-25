require 'spec_helper'

describe "measures/show" do
  before(:each) do
    @measure = assign(:measure, stub_model(Measure,
      :content => "Content",
      :display_order => 1,
      :weight => 2,
      :provider => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Content/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(//)
  end
end
