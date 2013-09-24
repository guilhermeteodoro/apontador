require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)

  Bundler.require(*Rails.groups(:assets => %w(development test)))

end

module Checker

  class Application < Rails::Application

    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.active_record.whitelist_attributes = true
    config.assets.initialize_on_precompile = false
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.yml").to_s]
    config.i18n.default_locale = :"pt-BR"

    #Gmail mailer configs
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
        :address                => "smtp.gmail.com",
        :port                   => 587,
        :domain                 => 'gmail.com',
        :user_name              => 'checkerbootcamp',
        :password               => '1A2b3c4d5e',
        :authentication         => 'plain',
        :enable_starttls_auto   => true
    }
  end

end