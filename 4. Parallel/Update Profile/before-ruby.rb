require "selenium-webdriver"

class BeforeTest
  def initialize(testCase,driver)
    @testCase =  testCase
    @driver =  driver
  end
  def run
    # Here some example
    # @driver.manage.window.resize_to(1600,1080)
    @driver.get "http://timeline.app/auth/login"

    element = @driver.find_element :css => '[name="email"]'
    @driver.execute_script("arguments[0].value=\"sunupf@gmail.com\"" , element)

    element = @driver.find_element :css => '[name="password"]'
    @driver.execute_script("arguments[0].value=\"qweasd123\"" , element)

    buttonSubmit = @driver.find_element :css => ".signup-page .card-signup .btn-primary"
    # buttonSubmit.click
    @driver.execute_script("arguments[0].click()" , buttonSubmit)
    #
    wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    wait.until { @driver.find_element :css => ".card.new" }

    # puts "Page title is #{@driver.title}"
  end
end
