require_relative "../../spec/rails_helper"

if ENV["SELENIUM_REMOTE_HOST"]
  RSpec.configure do |config|
    config.before(:each, type: :system) do
      Capybara.server = :puma, { Silent: true }
      driven_by :chrome_remote
      Capybara.app_host = ENV["CAPYBARA_APP_HOST"]
      Capybara.always_include_port = false
    end

    Capybara.register_driver :chrome_remote do |app|
      args = [
        "--disable-infobars",
        "--lang=de-DE",
        "--window-size=1200,900",
      ]
      caps = Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: args })

      Capybara::Selenium::Driver.new(
        app,
        browser: :remote,
        url: "http://#{ENV["SELENIUM_REMOTE_HOST"]}:4444/wd/hub",
        desired_capabilities: caps
      )
    end
    Capybara.server_port = ENV["RAILS_SERVER_PORT"] || "63800"
    Capybara.server_host = "0.0.0.0"
  end
else
  RSpec.configure do |config|
    config.before(:each, type: :system) do
      Capybara.server = :puma, { Silent: true }
      driven_by :chrome_headless
    end

    Capybara.register_driver :chrome_headless do |app|
      args = [
        "--no-sandbox",
        "--headless",
        "--disable-gpu",
        "--disable-infobars",
        "--lang=de-DE",
        "--window-size=1200,900",
      ]
      caps = Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: { args: args })

      Capybara::Selenium::Driver.new(
        app,
        browser: :chrome,
        desired_capabilities: caps
      )
    end
  end
end
