require 'spec_helper'

module EZAPIClient
  RSpec.describe ExecCommand, type: %i[virtus] do

    describe "attributes" do
      subject { described_class }
      it { is_expected.to have_attribute(:command, String) }
    end

    describe "#call" do
      context "no errors" do
        let(:command) do
          [
            "java -cp",
            JAR_PATH,
            "ezpadala.EZtoken",
            CONFIG[:prv_path],
            CONFIG[:eks_path],
            CONFIG[:username],
            CONFIG[:password],
            "TN0101010",
          ].join(" ")
        end
        let(:result) { described_class.new(command: command).() }

        it "returns the result" do
          expect(result).to be_a(String)
        end
      end

      context "errors" do
        let(:command) do
          [
            "java -cp",
            JAR_PATH,
            "ezpadala.EZtoken",
            CONFIG[:prv_path],
            CONFIG[:eks_path],
            CONFIG[:username],
            "fake",
            "TN0101010",
          ].join(" ")
        end
        let(:result) { described_class.new(command: command).() }

        it "raises StandardError" do
          expect { result }.to raise_error(StandardError)
        end
      end
    end

  end
end
