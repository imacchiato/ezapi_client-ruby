module EZAPIClient
  CreateTransactionRequestSchema = Dry::Validation.Schema(BaseSchema) do

    required(:reference_no).filled(:str?, max_size?: 25)

  end
end
