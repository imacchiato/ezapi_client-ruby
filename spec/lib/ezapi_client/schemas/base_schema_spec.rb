require 'spec_helper'

module EZAPIClient
  RSpec.describe "BaseSchema" do

    let(:schema) { BaseSchema.new }

    it "requires host" do
      message = schema.(host: "").messages[:host]
      expect(message).to include("must be filled")
    end

    it "requires username" do
      message = schema.(username: "").messages[:username]
      expect(message).to include("must be filled")
    end

    it "requires password" do
      message = schema.(password: "").messages[:password]
      expect(message).to include("must be filled")
    end

    it "requires eks_path" do
      message = schema.(eks_path: "").messages[:eks_path]
      expect(message).to include("must be filled")
    end

    it "requires eks_path to exist" do
      message = schema.(eks_path: "non/existent").messages[:eks_path]
      expect(message).to include("must exist")

      message = schema.(CONFIG.slice(:eks_path)).messages[:eks_path]
      expect(message).to be_nil
    end

    it "requires prv_path" do
      message = schema.(prv_path: "").messages[:prv_path]
      expect(message).to include("must be filled")
    end

    it "requires prv_path to exist" do
      message = schema.(prv_path: "non/existent").messages[:prv_path]
      expect(message).to include("must exist")

      message = schema.(CONFIG.slice(:prv_path)).messages[:prv_path]
      expect(message).to be_nil
    end

  end
end
