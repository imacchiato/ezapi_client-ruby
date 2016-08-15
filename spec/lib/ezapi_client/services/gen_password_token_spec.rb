require 'spec_helper'

module EZAPIClient
  RSpec.describe GenPasswordToken do

    it "generates a password token" do
      result = described_class.(
        prv_path: CONFIG[:prv_path],
        eks_path: CONFIG[:eks_path],
        username: CONFIG[:username],
        password: CONFIG[:password],
        reference_no: "TN00001",
      )
      expect(result).to be_a(String)
      expect(result).to be_present
    end

    context "fails to generate a token" do
      it "raises an error" do
        expect {
          described_class.(
            prv_path: CONFIG[:prv_path],
            eks_path: CONFIG[:eks_path],
            username: CONFIG[:username],
            password: "wrongpassword",
            reference_no: "TN00001",
          )
        }.to raise_error(ArgumentError)
      end
    end

  end
end
