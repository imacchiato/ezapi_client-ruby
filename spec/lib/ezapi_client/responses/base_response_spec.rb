require 'spec_helper'

module EZAPIClient
  RSpec.describe BaseResponse, type: %i[virtus] do

    describe "attributes" do
      subject { described_class }
      it { is_expected.to have_attribute(:raw_response) }
      it { is_expected.to have_attribute(:raw_body, String) }
      it { is_expected.to have_attribute(:response_body) }
      it { is_expected.to have_attribute(:success) }
      it { is_expected.to have_attribute(:code, String) }
      it { is_expected.to have_attribute(:message, String) }
    end

    describe "#response_body" do
      let(:response) { described_class.new(raw_body: raw_body) }
      subject(:response_body) { response.response_body }

      context "body is a proper JSON string" do
        let(:raw_body) { '{"hi": "there"}' }

        it "is the hashified body of #raw_body" do
          expect(response_body).to eq("hi" => "there")
          expect(response_body[:hi]).to eq "there"
        end
      end

      context "raw_body is not a proper JSON string" do
        let(:raw_body) { '' }
        it { is_expected.to be_nil }
      end
    end

    context "#raw_body" do
      let(:response) { described_class.new(raw_response: raw_response) }
      let(:raw_response) { instance_double(HTTParty::Response, body: '') }

      it "is the raw_response's body" do
        expect(response.raw_body).to eq ''
      end
    end

    describe "#success" do
      subject(:response) { described_class.new(response_body: response_body) }

      context "response_body is a hash" do
        let(:response_body) { {success: true} }

        it "defaults to #response_body's success" do
          expect(response.success).to be true
        end
      end

      context "response_body is nil" do
        let(:response_body) { nil }
        it { is_expected.to_not be_success }
      end
    end

    describe "#code" do
      let(:response) { described_class.new(response_body: response_body) }

      context "response_body has `code`" do
        let(:response_body) { {code: "IRP"} }
        it "defaults to #response_body's code" do
          expect(response.code).to eq "IRP"
        end
      end
    end

    describe "#message" do
      let(:response) do
        described_class.new(response_body: response_body)
      end

      context "response_body has `message`" do
        let(:response_body) { {message: "Missing or invalid..."} }

        it "defaults to #response_body's message" do
          expect(response.message).to eq "Missing or invalid..."
        end
      end
    end

  end
end
