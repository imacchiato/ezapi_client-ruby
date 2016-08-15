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
    end

  end
end
