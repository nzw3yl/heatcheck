require 'spec_helper'

describe "heat_logs/show" do
  before(:each) do
    @heat_log = assign(:heat_log, stub_model(HeatLog,
      :entity_type => "Entity Type",
      :entity_id => 1,
      :temperature => 2,
      :measure => nil,
      :provider_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Entity Type/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(//)
    rendered.should match(/3/)
  end
end
