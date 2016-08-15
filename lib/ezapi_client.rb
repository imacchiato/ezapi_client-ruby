require "active_support/concern"
require "active_support/core_ext/hash/indifferent_access"
require "active_support/core_ext/hash/slice"
require "active_support/core_ext/object"
require "active_support/json/encoding"
require "dry-validation"
require "httparty"
require "open3"
require "virtus"
require "ezapi_client/version"
require "ezapi_client/client"
require "ezapi_client/indifferent_hash"
require "ezapi_client/concerns/password_tokenizable"
require "ezapi_client/services/exec_command"
require "ezapi_client/services/gen_password_token"
require "ezapi_client/services/gen_data"
require "ezapi_client/requests/base_request"
require "ezapi_client/requests/create_transaction_request"
require "ezapi_client/responses/base_response"
require "ezapi_client/responses/create_transaction_response"
require "ezapi_client/schemas/base_schema"
require "ezapi_client/schemas/client_schema"
require "ezapi_client/schemas/create_transaction_request_schema"

module EZAPIClient

  JAR_PATH = File.join(File.dirname(__FILE__), "ezapi_client/bin/ezapi.jar")

  def self.new(opts)
    client = Client.new(opts)
    error_messages = ClientSchema.(client.attributes).
      messages(full: true).values
    raise ArgumentError, error_messages if error_messages.any?
    client
  end

end
