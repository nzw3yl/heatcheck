require 'spec_helper'

describe "contracts/edit" do
  before(:each) do
    @contract = assign(:contract, stub_model(Contract,
      :partner_id => 1,
      :customer_id => 1,
      :notes => "MyText"
    ))
  end

  it "renders the edit contract form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contract_path(@contract), "post" do
      assert_select "input#contract_partner_id[name=?]", "contract[partner_id]"
      assert_select "input#contract_customer_id[name=?]", "contract[customer_id]"
      assert_select "textarea#contract_notes[name=?]", "contract[notes]"
    end
  end
end
