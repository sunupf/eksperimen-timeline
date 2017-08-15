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
        first_pwd = arrayPassword.first
        second_pwd = arrayPassword.last
        element = @driver.find_element :css => key
        if(!first_pwd.nil?)
          first_pwd = first_pwd.gsub("\"","\\\"")
        end
        puts "arguments[0].value=\"#{first_pwd}\""
        @driver.execute_script("arguments[0].value=\"#{first_pwd}\"" , element)
        element = @driver.find_element :css => "[name='password_confirmation']"
        if(!second_pwd.nil?)
          second_pwd = second_pwd.gsub("\"","\\\"")
        end
        @driver.execute_script("arguments[0].value=\"#{second_pwd}\"" , element)
      else
        element = @driver.find_element :css => key
        if(!input.nil?)
          input = input.gsub("\"","\\\"")
        end
        @driver.execute_script("arguments[0].value=\"#{input}\"" , element)
      end
    end

    buttonSubmit = @driver.find_element :css => ".signup-page .card-signup .btn-primary"
    @driver.execute_script("arguments[0].click()" , buttonSubmit)
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

    # puts expect
    # puts "//////"
    # puts result
    # assertion
    return Set.new(expect) === Set.new(result)
  end
end
