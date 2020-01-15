module EZAPIClient
  class ExecCommand

    include Virtus.model
    attribute :command, String

    def self.call(command, logger = nil)
      if logger
        self.new(command: command).(logger)
      else
        self.new(command: command).()
      end
    end

    def call(logger = nil)
      stdout_str, stderr_str, status = Open3.capture3(command)
      unless status.success?
        error_msgs = [
          stdout_str,
          stderr_str,
        ].reject { |str| str == "" }.compact.join("; ")
        msg = ["Error executing command:", error_msgs].join(" ")
        logger.error(EZAPIClient::LOG_PROGNAME) { msg } if logger
        fail ArgumentError, msg
      end
      stdout_str.chomp
    end

  end
end
