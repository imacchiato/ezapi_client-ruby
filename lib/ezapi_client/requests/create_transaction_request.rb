module EZAPIClient
  class CreateTransactionRequest < BaseRequest

    include PasswordTokenizable
    DEFAULT_PATH = "/sfa/transactions/new_transaction"

    TRANS_TYPES = {
      "OAB" => "Opening account for Beneficiary",
      "OAR" => "Opening account for Remitter",
      "CBA" => "Credit to a bank account",
      "CCC" => "Credit or reload to a Credit/Debit/Cash/Prepaid Card",
      "DCD" => "Door-to-door Cash Delivery",
      "DCC" => "Door-to-door Cash Card Delivery",
      "DJP" => "Door-to-door Jollibee Padala",
      "DMP" => "Door-to-door Max's Padala",
      "DSC" => "Door-to-door SM Gift Card Delivery",
      "DRD" => "Door-to-door Rush Delivery",
      "PCA" => "Pickup Cash @ Anywhere",
      "PML" => "Pickup Cash @ MLhullier Kwarta Padala",
      "PCL" => "Pickup Cash @ Cebuana Lhullier",
    }.freeze

    TRANS_TYPE_CATEGORIES = {
      door_to_door: %w(DCD DCC DJP DMP DSC DRD),
    }.with_indifferent_access.freeze

    TRANS_TYPES_WITH_ACCOUNT_NUMBER = %w(OAB OAR CBA CCC).freeze
    TRANS_TYPES_WITHOUT_ACCOUNT_NUMBER =
      (TRANS_TYPES.keys - TRANS_TYPES_WITH_ACCOUNT_NUMBER).freeze

    attribute :reference_no, String
    attribute :trans_date, DateTime
    attribute :sender_lastname, String
    attribute :sender_firstname, String
    attribute :sender_middle_name, String
    attribute :sender_address1, String
    attribute :sender_address2, String
    attribute :sender_phone, String
    attribute :recipient_lastname, String
    attribute :recipient_firstname, String
    attribute :recipient_middle_name, String
    attribute :recipient_address1, String
    attribute :recipient_address2, String
    attribute :recipient_phone, String
    attribute :recipient_gender, String
    attribute :recipient_birthday, Date
    attribute :trans_type, String
    attribute :bank_code, String
    attribute :branch_name, String, lazy: true, default: :default_branch_name
    attribute :account_no, String
    attribute :landed_currency, String
    attribute :landed_amount, Float
    attribute :message1, String
    attribute :message2, String
    attribute :data, String, lazy: true, default: :default_data

    private

    def body
      attributes.slice(:username, :reference_no, :data).
        merge(password: password_token)
    end

    def default_branch_name
      return if trans_type != "CBA"
      return "MAKATI" if bank_code != "BDO"
      "BDO"
    end

    def default_path
      DEFAULT_PATH
    end

    def default_data
      message = %i[
        reference_no
        sender_lastname
        sender_firstname
        sender_middle_name
        sender_address1
        sender_address2
        sender_phone
        recipient_lastname
        recipient_firstname
        recipient_middle_name
        recipient_address1
        recipient_address2
        recipient_phone
        recipient_gender
        recipient_birthday
        trans_type
        bank_code
        branch_name
        landed_currency
        landed_amount
        message1
        message2
      ].each_with_object({}) { |attr, hash| hash[attr] = send(attr) }
      message[:trans_date] = trans_date.strftime("%Y-%m-%d %H:%M:%S %z")
      if TRANS_TYPES_WITH_ACCOUNT_NUMBER.include?(trans_type)
        message[:account_no] = account_no
      end

      GenData.(
        username: username,
        password: password,
        eks_path: eks_path,
        prv_path: prv_path,
        reference_no: reference_no,
        message: message,
        logger: logger,
        log: log,
      )
    end

  end
end
