require 'spec_helper'

module EZAPIClient
  RSpec.describe CreateTransactionRequest, type: %i[virtus] do

    it "is able to generate a password_token" do
      expect(described_class < PasswordTokenizable).to be true
    end

    describe "attributes" do
      subject { described_class }
      it { is_expected.to have_attribute(:reference_no, String) }
      it { is_expected.to have_attribute(:trans_date, DateTime) }
      it { is_expected.to have_attribute(:sender_lastname, String) }
      it { is_expected.to have_attribute(:sender_firstname, String) }
      it { is_expected.to have_attribute(:sender_middle_name, String) }
      it { is_expected.to have_attribute(:sender_address1, String) }
      it { is_expected.to have_attribute(:sender_address2, String) }
      it { is_expected.to have_attribute(:sender_phone, String) }
      it { is_expected.to have_attribute(:recipient_lastname, String) }
      it { is_expected.to have_attribute(:recipient_firstname, String) }
      it { is_expected.to have_attribute(:recipient_middle_name, String) }
      it { is_expected.to have_attribute(:recipient_address1, String) }
      it { is_expected.to have_attribute(:recipient_address2, String) }
      it { is_expected.to have_attribute(:recipient_phone, String) }
      it { is_expected.to have_attribute(:recipient_gender, String) }
      it { is_expected.to have_attribute(:recipient_birthday, Date) }
      it { is_expected.to have_attribute(:trans_type, String) }
      it { is_expected.to have_attribute(:bank_code, String) }
      it { is_expected.to have_attribute(:branch_name, String) }
      it { is_expected.to have_attribute(:account_no, String) }
      it { is_expected.to have_attribute(:landed_currency, String) }
      it { is_expected.to have_attribute(:landed_amount, Float) }
      it { is_expected.to have_attribute(:message1, String) }
      it { is_expected.to have_attribute(:message2, String) }
      it { is_expected.to have_attribute(:data, String) }
    end

    describe "#body" do
    end

    describe "#branch_name" do
      let(:request) do
        described_class.new(trans_type: trans_type, bank_code: bank_code)
      end
      subject(:branch_name) { request.branch_name }

      context "#trans_type is CBA, #bank_code is BDO" do
        let(:trans_type) { "CBA" }
        let(:bank_code) { "BDO" }
        it { is_expected.to eq "BDO" }
      end

      context "#trans_type is CBA, #bank_code is not BDO" do
        let(:trans_type) { "CBA" }
        let(:bank_code) { "ABC" }
        it { is_expected.to eq "MAKATI" }
      end

      context "#trans_type is not CBA" do
        let(:trans_type) { "OTHER" }
        let(:bank_code) { "NOTHING" }
        it { is_expected.to be_nil }
      end
    end

    describe "#data" do
      let(:trans_time) { DateTime.now }
      let(:attributes) do
        {
          reference_no: "reference_no",
          trans_date: trans_time,
          sender_lastname: "sender_lastname",
          sender_firstname: "sender_firstname",
          sender_middle_name: "sender_middle_name",
          sender_address1: "sender_address1",
          sender_address2: "sender_address2",
          sender_phone: "sender_phone",
          recipient_lastname: "recipient_lastname",
          recipient_firstname: "recipient_firstname",
          recipient_middle_name: "recipient_middle_name",
          recipient_address1: "recipient_address1",
          recipient_address2: "recipient_address2",
          recipient_phone: "recipient_phone",
          recipient_gender: "recipient_gender",
          recipient_birthday: "recipient_birthday",
          trans_type: trans_type,
          bank_code: "bank_code",
          branch_name: "branch_name",
          account_no: "account_no",
          landed_currency: "landed_currency",
          landed_amount: "landed_amount",
          message1: "message1",
          message2: "message2",
        }
      end
      let(:logger) { Logger.new(STDOUT) }
      let(:request) do
        described_class.new(attributes.merge(
          username: "username",
          password: "password",
          eks_path: "eks_path",
          prv_path: "prv_path",
          reference_no: "reference_no",
          logger: logger,
          log: true,
        ))
      end

      context "trans_type requires an account_no" do
        let(:trans_type) do
          described_class::TRANS_TYPES_WITH_ACCOUNT_NUMBER.sample
        end
        let(:message) do
          attributes.merge(
            trans_date: trans_time.strftime("%Y-%m-%d %H:%M:%S %z"),
          )
        end

        it "generates data from the attributes" do
          expect(GenData).to receive(:call).with(
            username: "username",
            password: "password",
            eks_path: "eks_path",
            prv_path: "prv_path",
            reference_no: "reference_no",
            message: message,
            logger: logger,
            log: true,
          ).and_return("data")
          expect(request.data).to eq "data"
        end
      end

      context "trans_type is does not require an account_no" do
        let(:trans_type) do
          described_class::TRANS_TYPES_WITHOUT_ACCOUNT_NUMBER.sample
        end
        let(:message) do
          attributes.merge(
            trans_date: trans_time.strftime("%Y-%m-%d %H:%M:%S %z"),
          ).except(:account_no)
        end

        it "excludes `account_no`" do
          expect(GenData).to receive(:call).with(
            username: "username",
            password: "password",
            eks_path: "eks_path",
            prv_path: "prv_path",
            reference_no: "reference_no",
            message: message,
            logger: logger,
            log: true,
          ).and_return("data")
          expect(request.data).to eq "data"
        end
      end
    end

    describe "#path" do
      it "defaults to #{described_class::DEFAULT_PATH}" do
        expect(described_class.new.path).to eq described_class::DEFAULT_PATH
      end
    end

  end
end
