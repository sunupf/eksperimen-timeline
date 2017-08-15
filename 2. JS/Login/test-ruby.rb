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
      element = @driver.find_element :css => key
      input = input.gsub("\"","\\\"")
      @driver.execute_script("arguments[0].value=\"#{input}\"" , element)
    end

    buttonSubmit = @driver.find_element :css => ".signup-page .card-signup .btn-primary"
    @driver.execute_script("arguments[0].click()" , buttonSubmit)
    #
    wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    wait.until { @driver.find_element :css => ".login.errors, .card.new" }
    #
    respons = @driver.find_elements :css => ".login.errors, .card.new"

    result = Array.new

    respons.each do |respon|
      result.push respon.text
    end

    expect = @testCase['messages']

    # puts expect
    # puts "//////"
    # puts result
    # assertion
    return Set.new(expect) === Set.new(result)
  end
end
