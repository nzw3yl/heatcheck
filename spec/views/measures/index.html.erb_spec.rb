require 'spec_helper'

describe "measures/index" do
  before(:each) do
    assign(:measures, [
      stub_model(Measure,
        :content => "Content",
        :display_order => 1,
        :weight => 2,
        :provider => nil
      ),
      stub_model(Measure,
        :content => "Content",
        :display_order => 1,
        :weight => 2,
        :provider => nil
      )
    ])
  end

  it "renders a list of measures" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
