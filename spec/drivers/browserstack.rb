require 'browserstack/local'

module BrowserstackTest::Capabilities
  def capabilities
    default_capabilities.merge opts_for(ENV["BROWSER"])
  end

  def default_capabilities
  # ref https://www.browserstack.com/automate/capabilities
  { "os" => "Windows",
    "os_version" => "10",
    "project"=>"BrowserstackTest",
    "build"=>"rspec-capybara-browserstack",
    "browserstack.debug"=>true,
    "browserstack.local"=>true,
    "browserstack.networkLogs"=>true }
  end

  private
  def opts_for(browser)
    case browser
    when "ie"
      { "browser" => "Internet Explorer",
        "browser_version" => "11.0",
        "browserstack.selenium_version" => "2.53.1",
        "browserstack.ie.driver" => "2.53.1",
        "browserstack.ie.arch" => "x32" }
    else
      { "browser" => "Chrome",
        "browser_version" => "68.0",
        "browserstack.selenium_version" => "3.11.0"}
    end
  end

end


Capybara.register_driver :browserstack do |app|
  include BrowserstackTest::Capabilities
  key = ENV['browserstack_key']
  user = ENV['browserstack_user']
  server = "hub-cloud.browserstack.com"

  @bs_local = BrowserStack::Local.new
  @bs_local.start({"key" => key})
  url = "http://#{user}:#{key}@#{server}/wd/hub"

  Capybara::Selenium::Driver.new(app,
    :browser => :remote,
    :url => url,
    :desired_capabilities => capabilities
  )
end
