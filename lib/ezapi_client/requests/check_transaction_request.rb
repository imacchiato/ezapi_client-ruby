module EZAPIClient
  class CheckTransactionRequest < BaseRequest

    include PasswordTokenizable
    DEFAULT_PATH = "/sfa/transactions/check_transaction"

    attribute :reference_no, String

    private

    def body
      attributes.slice(:username, :reference_no).merge(password: password_token)
    end

    def default_path
      DEFAULT_PATH
    end

  end
end
