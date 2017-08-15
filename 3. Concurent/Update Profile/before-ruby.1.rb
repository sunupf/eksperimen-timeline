require "selenium-webdriver"

class BeforeTest
  def initialize(testCase,driver)
    @testCase =  testCase
    @driver =  driver
  end
  def run
    # Here some example
    # @driver.manage.window.resize_to(1600,1080)
    @driver.manage.delete_all_cookies
    @driver.get "http://timeline.app/auth/login"

    element = @driver.find_element :css => '[name="email"]'
    element.send_keys "sunupf@gmail.com"

    element = @driver.find_element :css => '[name="password"]'
    element.send_keys "qweasd123"

    buttonSubmit = @driver.find_element :css => ".signup-page .card-signup .btn-primary"
    buttonSubmit.click
    #
    wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    wait.until { @driver.find_element :css => ".card.new" }

    # puts "Page title is #{@driver.title}"
  end
end
