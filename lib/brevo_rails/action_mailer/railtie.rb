# frozen_string_literal: true

module BrevoRails
  module ActionMailer
    class Railtie < Rails::Railtie
      initializer 'brevo_action_mailer.add_delivery_method', before: 'action_mailer.set_configs' do
        ActiveSupport.on_load(:action_mailer) do
          ::ActionMailer::Base.add_delivery_method(:brevo, BrevoRails::ActionMailer::DeliveryMethod)
        end
      end
    end
  end
end
