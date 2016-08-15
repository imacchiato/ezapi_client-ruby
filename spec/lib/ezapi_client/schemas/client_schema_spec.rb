require 'spec_helper'

module EZAPIClient
  RSpec.describe "ClientSchema" do

    it "inherits from BaseSchema" do
      expect(ClientSchema.class < BaseSchema).to be true
    end

  end
end
