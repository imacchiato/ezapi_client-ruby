module EZAPIClient
  class BaseSchema < Dry::Validation::Schema

    configure do
      config.messages_file = File.join(File.dirname(__FILE__), "errors.yml")

      def exists?(value)
        File.exists?(value)
      end
    end

    define! do
      required(:host).filled
      required(:username).filled
      required(:password).filled
      required(:eks_path).filled(:exists?)
      required(:prv_path).filled(:exists?)
    end

  end
end
