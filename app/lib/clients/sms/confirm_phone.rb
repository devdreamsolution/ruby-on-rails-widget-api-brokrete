# frozen_string_literal: true

module Clients::Sms
  class ConfirmPhone < Base

    def deliver(name: nil, to:, code:)
      super(
        from: from,
        to: to(to),
        message: message(code),
      )
    end

    private

    def message(code)
      <<~PLAIN
        Security code: #{code}
      PLAIN
    end

    def from
      ENV["CONFIRMATION_SMS_FROM"]
    end

    def to(value)
      Phonelib.parse(value).international
    end

  end
end
