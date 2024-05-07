# Unofficial Brevo Action Mailer adapter

brevo_rails is an Action Mailer adapter for using Brevo in Ruby on Rails application. It uses Brevo gem to make API request to Brevo service.

## Installation

In your Gemfile

```ruby
gem 'brevo-rails'
```

## Usage

Add these lines in your configuration file.

```ruby
config.action_mailer.delivery_method = :brevo
config.action_mailer.brevo_settings = {
  api_key: ENV.fetch('BREVO_API_KEY'),
}
```
