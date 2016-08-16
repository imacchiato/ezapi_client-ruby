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
        fail(ArgumentError, "Error executing command: #{stderr_str}")
      end
      stdout_str.chomp
    end

  end
end
