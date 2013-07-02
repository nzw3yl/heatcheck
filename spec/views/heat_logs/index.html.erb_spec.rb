require 'spec_helper'

describe "heat_logs/index" do
  before(:each) do
    assign(:heat_logs, [
      stub_model(HeatLog,
        :entity_type => "Entity Type",
        :entity_id => 1,
        :temperature => 2,
        :measure => nil,
        :provider_id => 3
      ),
      stub_model(HeatLog,
        :entity_type => "Entity Type",
        :entity_id => 1,
        :temperature => 2,
        :measure => nil,
        :provider_id => 3
      )
    ])
  end

  it "renders a list of heat_logs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Entity Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
