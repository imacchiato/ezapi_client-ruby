require 'spec_helper'

module EZAPIClient
  RSpec.describe PasswordTokenizable do

    let(:klass) do
      Class.new(BaseRequest) do
        attribute :reference_no, String
        include PasswordTokenizable
      end
    end
    let(:tokenizable) do
      klass.new(
        prv_path: "/prv_path",
        eks_path: "/eks_path",
        username: "username",
        password: "password",
        reference_no: "reference_no",
      )
    end

    it "adds #password_token to the object" do
      expect(GenPasswordToken).to receive(:call).with(
        prv_path: "/prv_path",
        eks_path: "/eks_path",
        username: "username",
        password: "password",
        reference_no: "reference_no",
      ).and_return("password_token")

      expect(tokenizable.password_token).to eq "password_token"
    end

  end
end
