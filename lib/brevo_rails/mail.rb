# frozen_string_literal: true

require 'base64'
require 'active_support/core_ext/hash/keys'

module BrevoRails
  class Mail

    class << self
      def from_message(message)
        params = {
          sender: prepare_sender(address_list(message['from'])&.addresses&.first),
          to: prepare_to(address_list(message['to'])&.addresses),
          subject: message.subject,
          'textContent': prepare_text_part(message),
          'htmlContent': prepare_html_part(message),
          headers: prepare_headers(message),
        }.stringify_keys

        params['cc'] = prepare_cc(address_list(message['cc'])&.addresses) if message['cc']
        params['bcc'] = prepare_bcc(address_list(message['bcc'])&.addresses) if message['bcc']
        params['attachment'] = prepare_attachments(message.attachments) if message.attachments.any?
        params['tags'] = message['tags']&.unparsed_value if message['tags']

        Brevo::SendSmtpEmail.new(params)
      end

      private

        PROCESSED_HEADERS = %w[
          from
          to
          cc
          bcc
          subject
        ].freeze

        def prepare_headers(message)
          message
            .header_fields
            .reject { |header| PROCESSED_HEADERS.include?(header.name.downcase.delete('-')) }
            .to_h { |header| [header.name, header.value] }
            .compact
        end

        def prepare_sender(sender)
          Brevo::SendSmtpEmailSender.new(prepare_address(sender))
        end

        def prepare_to(addresses=[])
          Array(addresses).map do |address|
            Brevo::SendSmtpEmailTo.new(prepare_address(address))
          end
        end

        def prepare_cc(addresses=[])
          Array(addresses).map do |address|
            Brevo::SendSmtpEmailCc.new(prepare_address(address))
          end
        end

        def prepare_bcc(addresses=[])
          Array(addresses).map do |address|
            Brevo::SendSmtpEmailBcc.new(prepare_address(address))
          end
        end

        def prepare_address(address)
          {
            email: address.address,
            name: address.display_name,
          }.stringify_keys.compact
        end

        def address_list(header)
          header.respond_to?(:element) ? header.element : header&.address_list
        end

        # def prepare_addresses(addresses)
        #   Array(addresses).map { |address| prepare_address(address) }
        # end

        def prepare_html_part(message)
          return message.body.decoded if message.mime_type == 'text/html'

          message.html_part&.decoded
        end

        def prepare_text_part(message)
          return message.body.decoded if message.mime_type == 'text/plain' || message.mime_type.nil?

          message.text_part&.decoded
        end

        def prepare_attachments(attachments_list = [])
          attachments_list.map do |attachment|
            params = {
              content: Base64.strict_encode64(attachment.body.decoded),
              name: attachment.filename,
            }.stringify_keys
            Brevo::SendSmtpEmailAttachment.new(params)
          end
        end

    end
  end
end
