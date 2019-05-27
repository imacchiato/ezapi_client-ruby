module EZAPIClient
  class BaseResponse

    include Virtus.model
    attribute :raw_response, Object
    attribute :raw_body, String, lazy: true, default: :default_raw_body
    attribute(:response_body, IndifferentHash, {
      lazy: true,
      default: :default_response_body,
    })
    attribute :success, Boolean, lazy: true, default: :default_success
    attribute :code, String, lazy: true, default: :default_code
    attribute :message, String, lazy: true, default: :default_message

    private

    def default_success
      return false if response_body.nil?
      response_body[:success]
    end

    def default_raw_body
      raw_response.body
    end

    def default_response_body
      JSON.parse(raw_body)
    rescue JSON::ParserError
      nil
    end

    def default_code
      response_body[:code]
    end

    def default_message
      response_body[:message]
    end

  end
end
