require 'spec_helper'

describe "measures/edit" do
  before(:each) do
    @measure = assign(:measure, stub_model(Measure,
      :content => "MyString",
      :display_order => 1,
      :weight => 1,
      :provider => nil
    ))
  end

  it "renders the edit measure form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", measure_path(@measure), "post" do
      assert_select "input#measure_content[name=?]", "measure[content]"
      assert_select "input#measure_display_order[name=?]", "measure[display_order]"
      assert_select "input#measure_weight[name=?]", "measure[weight]"
      assert_select "input#measure_provider[name=?]", "measure[provider]"
    end
  end
end
