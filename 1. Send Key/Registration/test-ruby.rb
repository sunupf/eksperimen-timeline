require "selenium-webdriver"

class Test
  def initialize(testCase,driver)
    @testCase =  testCase
    @driver =  driver
  end
  def run
    # Here some example

    inputs = @testCase['testCases']
    inputs.each do |key,input|
      if key=="[name='password']"
        arrayPassword = input.split("#confirm#")
        element = @driver.find_element :css => key
        element.send_keys arrayPassword.first
        element = @driver.find_element :css => "[name='password_confirmation']"
        element.send_keys arrayPassword.last
      else
        element = @driver.find_element :css => key
        element.send_keys input
      end
    end

    buttonSubmit = @driver.find_element :css => ".signup-page .card-signup .btn-primary"
    buttonSubmit.click
    #
    wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    wait.until { @driver.find_element :css => "span.errors, .card.new" }
    #

    respons = @driver.find_elements :css => "span.errors, .card.new"


    result = Array.new

    respons.each do |respon|
      result.push respon.text
    end

    expect = @testCase['messages']

    puts expect
    puts "//////"
    puts result
    # assertion
    return Set.new(expect) === Set.new(result)
  end
end
