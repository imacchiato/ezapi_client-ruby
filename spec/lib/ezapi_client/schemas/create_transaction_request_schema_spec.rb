require 'spec_helper'

module EZAPIClient
  RSpec.describe CreateTransactionRequestSchema do

    it "inherits from BaseSchema" do
      expect(CreateTransactionRequestSchema.class < BaseSchema).to be true
    end

  end
end
