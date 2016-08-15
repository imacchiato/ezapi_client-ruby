module EZAPIClient
  class GenPasswordToken

    include Virtus.model
    attribute :eks_path, String
    attribute :prv_path, String
    attribute :username, String
    attribute :password, String
    attribute :reference_no, String
    attribute :command, String, lazy: true, default: :default_command

    def self.call(args)
      self.new(args).call
    end

    def call
      ExecCommand.(command)
    end

    private

    def default_command
      [
        "java -cp",
        JAR_PATH,
        "ezpadala.EZtoken",
        prv_path,
        eks_path,
        username,
        password,
        reference_no,
      ].join(" ")
    end

  end
end
