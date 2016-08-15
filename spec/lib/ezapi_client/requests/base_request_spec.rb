require 'spec_helper'

module EZAPIClient
  RSpec.describe BaseRequest, type: %i[virtus] do

    describe "attributes" do
      subject { described_class }
      it { is_expected.to have_attribute(:username, String) }
      it { is_expected.to have_attribute(:password, String) }
      it { is_expected.to have_attribute(:eks_path, String) }
      it { is_expected.to have_attribute(:prv_path, String) }
      it { is_expected.to have_attribute(:host, String) }
      it { is_expected.to have_attribute(:path, String) }
      it { is_expected.to have_attribute(:endpoint, String) }
    end

    describe "#endpoint" do
      it "is the host + endpoint" do
        request = described_class.new(host: "https://abc.com", path: "/there")
        expect(request.endpoint).to eq "https://abc.com/there"

        request = described_class.new(host: "https://abc.com:8080", path: "t")
        expect(request.endpoint).to eq "https://abc.com:8080/t"
      end
    end

  end
end
