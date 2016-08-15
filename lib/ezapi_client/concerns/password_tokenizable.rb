module EZAPIClient
  module PasswordTokenizable

    extend ActiveSupport::Concern

    included do
      attribute(:password_token, String, {
        lazy: true,
        default: :default_password_token,
      })
    end

    private

    def default_password_token
      GenPasswordToken.(
        prv_path: prv_path,
        eks_path: eks_path,
        username: username,
        password: password,
        reference_no: reference_no,
      )
    end

  end
end
