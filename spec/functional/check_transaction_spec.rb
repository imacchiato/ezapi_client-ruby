require 'spec_helper'

RSpec.describe "#check_transaction" do

  let(:reference_no) { SecureRandom.hex(12) }

  it "checks a transaction", vcr: {record: :once} do
    client_opts = CONFIG.slice(*%i[host username password eks_path prv_path])
    client = EZAPIClient.new(client_opts)

    create_transaction_response = client.create_transaction(
      reference_no: reference_no,
      trans_date: Date.today,
      sender_lastname: "Boghossian",
      sender_firstname: "Peter",
      sender_address1: "Portland",
      recipient_lastname: "Harris",
      recipient_firstname: "Sam",
      recipient_address1: "LA",
      recipient_phone: "+63919929199",
      trans_type: "CBA",
      bank_code: "BDO",
      account_no: "100661036243",
      landed_currency: "PHP",
      landed_amount: 2005.0,
    )

    response = client.check_transaction(reference_no: reference_no)
    expect(["PAID", "IN PROCESS", "PENDING"]).to include(response.code)

    expect(response).to be_success
  end

end
