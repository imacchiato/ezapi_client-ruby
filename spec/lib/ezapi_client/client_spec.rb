require 'spec_helper'

module EZAPIClient
  RSpec.describe Client, type: %i[virtus] do

    describe "attributes" do
      subject { described_class }
      it { is_expected.to have_attribute(:host, String) }
      it { is_expected.to have_attribute(:username, String) }
      it { is_expected.to have_attribute(:password, String) }
      it { is_expected.to have_attribute(:eks_path, String) }
      it { is_expected.to have_attribute(:prv_path, String) }
      it { is_expected.to have_attribute(:logger) }
      it { is_expected.to have_attribute(:log) }
    end

    describe "#log" do
      let(:client) { described_class.new }

      it "defaults to `false`" do
        expect(client).to_not be_log
      end
    end

  end
end
