require 'spec_helper'

describe "measures/new" do
  before(:each) do
    assign(:measure, stub_model(Measure,
      :content => "MyString",
      :display_order => 1,
      :weight => 1,
      :provider => nil
    ).as_new_record)
  end

  it "renders new measure form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", measures_path, "post" do
      assert_select "input#measure_content[name=?]", "measure[content]"
      assert_select "input#measure_display_order[name=?]", "measure[display_order]"
      assert_select "input#measure_weight[name=?]", "measure[weight]"
      assert_select "input#measure_provider[name=?]", "measure[provider]"
    end
  end
end
