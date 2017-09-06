module EZAPIClient
  class BaseRequest

    include Virtus.model
    attribute :username, String
    attribute :password, String
    attribute :eks_path, String
    attribute :prv_path, String
    attribute :host, String
    attribute :path, String, lazy: true, default: :default_path
    attribute :endpoint, String, lazy: true, default: :default_endpoint
    attribute :logger, Object
    attribute :log, Boolean

    def call
      HTTParty.post(endpoint, {
        headers: { 'Content-Type' => "application/json" },
        body: body.to_json,
      })
    end

    private

    def default_endpoint
      full_path = if path.nil?
                    nil
                  elsif path[0].eql?("/")
                    path
                  else
                    "/#{path}"
                  end

      uri = URI.parse(host)
      uri.path = full_path
      uri.to_s
    end

    def default_path
      fail "Override me"
    end

  end
end
