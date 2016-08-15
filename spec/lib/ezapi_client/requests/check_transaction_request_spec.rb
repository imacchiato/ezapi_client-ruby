require 'spec_helper'

module EZAPIClient
  RSpec.describe CheckTransactionRequest, type: %i[virtus] do

    it "is able to generate a password_token" do
      expect(described_class < PasswordTokenizable).to be true
    end

    describe "attributes" do
      subject { described_class }
      it { is_expected.to have_attribute(:reference_no, String) }
    end

    describe "#path" do
      it "defaults to #{described_class::DEFAULT_PATH}" do
        expect(described_class.new.path).to eq described_class::DEFAULT_PATH
      end
    end

  end
end
