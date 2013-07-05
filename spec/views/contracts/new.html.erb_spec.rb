require 'spec_helper'

describe "contracts/new" do
  before(:each) do
    assign(:contract, stub_model(Contract,
      :partner_id => 1,
      :customer_id => 1,
      :notes => "MyText"
    ).as_new_record)
  end

  it "renders new contract form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contracts_path, "post" do
      assert_select "input#contract_partner_id[name=?]", "contract[partner_id]"
      assert_select "input#contract_customer_id[name=?]", "contract[customer_id]"
      assert_select "textarea#contract_notes[name=?]", "contract[notes]"
    end
  end
end
