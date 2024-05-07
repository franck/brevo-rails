# frozen_string_literal: true

require 'brevo'

require_relative 'brevo_rails/action_mailer' if defined? ActionMailer
require_relative 'brevo_rails/mail'
require_relative 'brevo_rails/version'

module BrevoRails; end
