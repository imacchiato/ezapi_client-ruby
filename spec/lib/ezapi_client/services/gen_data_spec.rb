require 'spec_helper'

module EZAPIClient
  RSpec.describe GenData do

    describe "#json" do
      let(:message) do
        { reference_no: "referenceNo", trans_date: "2011-11-12".to_date }
      end
      let(:message_special_char) do
          {
            reference_no: "referenceNo",
            trans_date: "2011-11-12".to_date,
            sender_address1: "St Jul-ian's",
          }
        end

      it "is attributes with lower camelcase keys" do
        generator = described_class.new(message: message)

        expect(generator.json).to eq({
          referenceNo: "referenceNo",
          transDate: "2011-11-12",
        }.to_json)
      end

      it "strips special characters" do
        generator = described_class.new(message: message_special_char)

        expect(generator.json).to eq({
          referenceNo: "referenceNo",
          transDate: "2011-11-12",
          senderAddress1: "St Jul-ians",
        }.to_json)
      end
    end

    describe "#command" do
      let(:generator) do
        described_class.new(
          username: "uname",
          password: "pass",
          prv_path: "prv",
          eks_path: "eks",
          reference_no: "tn1",
          json: { hi: "d'there" }.to_json
        )
      end

      it "is the command to execute the java jarfile" do
        expected_json = %Q({"hi":"d\'there"})
        expect(generator.command).
          to eq %Q(java -cp #{JAR_PATH} ezpadala.EZdata prv eks uname pass tn1 '#{expected_json}')
      end

      context "log is true" do
        let(:logger) { Logger.new("tmp/test.log") }
        let(:generator) do
          described_class.new(command: "exec me", logger: logger, log: true)
        end

        before do
          FileUtils.rm_f "tmp/test.log"
          FileUtils.mkdir_p "tmp"
        end

        it "logs to the logger with the progname" do
          expect(ExecCommand).to receive(:call).with("exec me", logger)
          generator.()

          expect(File.read("tmp/test.log")).
            to include("#{EZAPIClient::LOG_PROGNAME}: exec me")
        end
      end

      context "log is false" do
        let(:logger) { Logger.new("tmp/test.log") }
        let(:generator) do
          described_class.new(command: "exec me", logger: logger, log: false)
        end

        before do
          FileUtils.rm_f "tmp/test.log"
          FileUtils.mkdir_p "tmp"
        end

        it "logs to the logger with the progname" do
          expect(ExecCommand).to receive(:call).with("exec me")
          generator.()

          expect(File.read("tmp/test.log")).
            to_not include("#{EZAPIClient::LOG_PROGNAME}: exec me")
        end
      end
    end

    describe "#call" do
      let(:generator) { described_class.new(command: "command") }

      it "generates encrypted data" do
        expect(ExecCommand).to receive(:call).with("command").
          and_return("result")
        expect(generator.()).to eq "result"
      end
    end

  end
end
