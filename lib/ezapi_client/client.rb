module EZAPIClient
  class Client

    include Virtus.model
    attribute :host, String
    attribute :username, String
    attribute :password, String
    attribute :eks_path, String
    attribute :prv_path, String

    def create_transaction(args)
      opts = default_opts.merge(args)
      request = CreateTransactionRequest.new(opts)
      error_messages = CreateTransactionRequestSchema.
        (request.attributes).messages(full: true).values
      fail ArgumentError, error_messages if error_messages.any?
      CreateTransactionResponse.new(raw_response: request.())
    end

    def check_transaction(args)
      opts = default_opts.merge(args)
      request = CheckTransactionRequest.new(opts)
      error_messages = CheckTransactionRequestSchema.
        (request.attributes).messages(full: true).values
      fail ArgumentError, error_messages if error_messages.any?
      CheckTransactionResponse.new(raw_response: request.())
    end

    private

    def default_opts
      attributes
    end

  end
end
