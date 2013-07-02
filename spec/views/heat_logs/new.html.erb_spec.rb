require 'spec_helper'

describe "heat_logs/new" do
  before(:each) do
    assign(:heat_log, stub_model(HeatLog,
      :entity_type => "MyString",
      :entity_id => 1,
      :temperature => 1,
      :measure => nil,
      :provider_id => 1
    ).as_new_record)
  end

  it "renders new heat_log form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", heat_logs_path, "post" do
      assert_select "input#heat_log_entity_type[name=?]", "heat_log[entity_type]"
      assert_select "input#heat_log_entity_id[name=?]", "heat_log[entity_id]"
      assert_select "input#heat_log_temperature[name=?]", "heat_log[temperature]"
      assert_select "input#heat_log_measure[name=?]", "heat_log[measure]"
      assert_select "input#heat_log_provider_id[name=?]", "heat_log[provider_id]"
    end
  end
end
