require 'spec_helper'

require 'brevo_rails/action_mailer/delivery_method'

RSpec.describe BrevoRails::ActionMailer::DeliveryMethod do
  let(:message) do
    Mail.new do
      from    'Tester <test@example.com>'
      to      'you@example.com, her@example.com'
      subject 'This is a test email'
    end
  end

  describe '#initialize' do
    it 'sets the api_key' do
      subject = described_class.new(api_key: '123')
      expect(subject.settings[:api_key]).to eq('123')
    end
  end

  describe '#deliver!' do
    it 'calls send_transac_email' do
      mail = double(Mail)
      expect(BrevoRails::Mail).to receive(:from_message).and_return(mail)
      expect_any_instance_of(Brevo::TransactionalEmailsApi).to receive(:send_transac_email).with(mail)
      described_class.new(api_key: '123').deliver!(message)
    end
  end

end
