module EZAPIClient
  class ExecCommand

    include Virtus.model
    attribute :command, String

    def self.call(command)
      self.new(command: command).()
    end

    def call
      stdout_str, stderr_str, status = Open3.capture3(command)
      unless status.success?
        error_msgs = [
          stdout_str,
          stderr_str,
        ].reject { |str| str == "" }.compact.join("; ")
        msg = ["Error executing command:", error_msgs].join(" ")
        fail ArgumentError, msg
      end
      stdout_str.chomp
    end

  end
end
