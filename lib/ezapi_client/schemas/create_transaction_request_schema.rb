module EZAPIClient
  CreateTransactionRequestSchema = Dry::Validation.Schema(BaseSchema) do

    BANK_TRANS_TYPE = "CBA"

    required(:reference_no).filled(:str?, max_size?: 20)
    required(:trans_date).filled(:date_time?)
    required(:sender_lastname).filled(:str?, max_size?: 40)
    required(:sender_firstname).filled(:str?, max_size?: 40)
    required(:sender_middle_name).maybe(:str?, max_size?: 1)
    required(:sender_address1).filled(:str?, max_size?: 75)
    required(:sender_address2).maybe(:str?, max_size?: 75)
    required(:sender_phone).maybe(:str?, max_size?: 30)
    required(:recipient_lastname).filled(:str?, max_size?: 40)
    required(:recipient_firstname).filled(:str?, max_size?: 40)
    required(:recipient_middle_name).maybe(:str?, max_size?: 1)
    required(:recipient_address1).filled(:str?, max_size?: 75)
    required(:recipient_address2).maybe(:str?, max_size?: 75)
    required(:recipient_phone).maybe(:str?, max_size?: 30)
    required(:recipient_gender).maybe(:str?, max_size?: 1)
    required(:recipient_birthday).maybe(:date?)
    required(:trans_type).filled(:str?, {
      max_size?: 3,
      included_in?: CreateTransactionRequest::TRANS_TYPES.keys,
    })
    required(:bank_code).maybe(:str?, max_size?: 5)
    required(:branch_name).maybe(:str?, max_size?: 40)
    required(:account_no).maybe(:str?, max_size?: 20)
    required(:landed_currency).filled(:str?, {
      max_size?: 3,
      included_in?: %w(USD PHP),
    })
    required(:landed_amount).filled(:float?)
    required(:message1).maybe(:str?, max_size?: 50)
    required(:message2).maybe(:str?, max_size?: 50)

    rule(
      recipient_birthday_presence: %i[trans_type recipient_birthday]
    ) do |trans_type, recipient_birthday|
      trans_types = CreateTransactionRequest::\
        TRANS_TYPE_CATEGORIES[:door_to_door]
      trans_type.included_in?(trans_types).then(recipient_birthday.filled?)
    end

    rule(bank_code_presence: %i[trans_type bank_code]) do |trans_type, bank_code|
      trans_type.eql?(BANK_TRANS_TYPE).then(bank_code.filled?)
    end

    rule(
      branch_name_presence: %i[trans_type branch_name]
    ) do |trans_type, branch_name|
      trans_type.eql?(BANK_TRANS_TYPE).then(branch_name.filled?)
    end

    rule(
      account_no_presence: %i[trans_type account_no]
    ) do |trans_type, account_no|
      trans_type.eql?(BANK_TRANS_TYPE).then(account_no.filled?)
    end

    rule(
      recipient_phone_presence: %i[trans_type recipient_phone]
    ) do |trans_type, recipient_phone|
      trans_types = %w(PCA CBA DCD DCC DJP DMP)
      trans_type.included_in?(trans_types).then(recipient_phone.filled?)
    end

  end
end
