# frozen_string_literal: true

module BrevoRails
  module ActionMailer
    class DeliveryMethod
      attr_accessor :settings

      ALLOWED_PARAMS = %i[api_key].freeze

      def initialize(settings)
        self.settings = settings
      end

      def deliver!(message)
        mail = BrevoRails::Mail.from_message(message)

        api.send_transac_email(mail)
      end

      private

        def api
          @api ||= Brevo::TransactionalEmailsApi.new(api_client)
        end

        def api_client
          @api_client ||= Brevo::ApiClient.new(configuration)
        end

        def configuration
          @configuration ||= Brevo::Configuration.new.tap do |config|
            config.api_key['api-key'] = settings.fetch(:api_key)
            config.debugging = settings.fetch(:debugging, false)
          end
        end
    end
  end
end
