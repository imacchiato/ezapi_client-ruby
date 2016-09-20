require 'spec_helper'

RSpec.describe "#create_transaction" do

  let(:reference_no) { CONFIG[:agent_code] + SecureRandom.hex(7) }

  it "creates a transaction", vcr: {record: :once} do
    client_opts = CONFIG.slice(*%i[host username password eks_path prv_path])
    puts client_opts
    client = EZAPIClient.new(client_opts)

    response = client.create_transaction(
      reference_no: reference_no,
      trans_date: Time.now,
      sender_lastname: "Boghossian",
      sender_firstname: "Peter",
      sender_address1: "Portland",
      recipient_lastname: "Harris",
      recipient_firstname: "Sam",
      recipient_address1: "LA",
      recipient_phone: "+639199291099",
      trans_type: "CBA",
      bank_code: "BDO",
      account_no: "100661036243",
      landed_currency: "PHP",
      landed_amount: 2005.0
    )

    expect(response).to be_success
  end

end
