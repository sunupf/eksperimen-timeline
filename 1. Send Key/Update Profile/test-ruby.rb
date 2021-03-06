require "selenium-webdriver"

class Test
  def initialize(testCase,driver)
    @testCase =  testCase
    @driver =  driver
  end
  def run
    # Here some example
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until { @driver.find_element :css => '.profile .edit-profile' }

    edit = @driver.find_element :css => '.profile .edit-profile';
    edit.click

    wait.until { @driver.find_element(:css => '#editProfile .modal-dialog .profile-form').displayed? }

    inputs = @testCase['testCases']
    inputs.each do |key,input|
      element = @driver.find_element :css => key
      element.clear
      if key=="[name='password']"
        arrayPassword = input.split("#confirm#")
        element.send_keys arrayPassword.first
        element = @driver.find_element :css => "[name='password_confirmation']"
        element.send_keys arrayPassword.last
      else
        for i in 0..input.length
          element.send_keys input[i]
        end
      end
    end

    buttonSubmit = @driver.find_element :css => "#editProfile .btn-primary"
    buttonSubmit.click

    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    respons = wait.until { 
      el = @driver.find_elements(:css => '.modal-dialog .alert.alert-success .message') 
      if el[0].displayed?
        el
      else
        el2 = @driver.find_elements(:css => '#editProfile span.errors') 
        if !el2.empty?
          el2  
        end
      end
    }

    # puts element
    # el = @driver.find_element(:css => '.modal-dialog .alert.alert-success .message') 

    # if el.displayed?
    #   respons =  @driver.find_elements :css => '.modal-dialog .alert.alert-success .message'
    # else  
    #   respons = @driver.find_elements :css => "#editProfile span.errors"
    # end

    result = Array.new

    respons.each do |respon|
      result.push respon.text
    end

    expect = @testCase['messages']

    puts expect
    puts "///"
    puts result

    return Set.new(expect) === Set.new(result)
  end
end
