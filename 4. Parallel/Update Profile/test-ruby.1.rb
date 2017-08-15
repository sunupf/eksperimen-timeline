require "selenium-webdriver"

class Test
  def initialize(testCase,driver)
    @testCase =  testCase
    @driver =  driver
  end
  def run
    # Here some example
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)

    edit = wait.until { 
      el = @driver.find_element :css => '.profile .edit-profile' 
      el if el.displayed?
    }
    edit.click
    # # edit.send_keys:return

    # puts "EDIT KE KLIK----"

    wait.until { @driver.find_element(:css => '#editProfile .modal-dialog .profile-form').displayed? }

    inputs = @testCase['testCases']
    inputs.each do |key,input|
      element = wait.until { 
        el = @driver.find_element :css => key
        el if el.displayed?
      }
      element.clear
      if key=="[name='password']"
        arrayPassword = input.split("#confirm#")
        input="";
        if(!arrayPassword.first.nil?)
          input = arrayPassword.first.gsub("\"","\\\"")
        end
        @driver.execute_script("arguments[0].value=\"#{input}\"" , element)
       
        input="";
        element = @driver.find_element :css => "[name='password_confirmation']"
        if(!arrayPassword.last.nil?)
          input = arrayPassword.last.gsub("\"","\\\"")
        end
        @driver.execute_script("arguments[0].value=\"#{input}\"" , element)
      else
        input = input.gsub("\"","\\\"")
        @driver.execute_script("arguments[0].value=\"#{input}\"" , element)
      end
    end

    buttonSubmit = wait.until { 
      el = @driver.find_element :css => "#editProfile .btn-primary" 
      el if el.displayed?
    }
    buttonSubmit.click
    # buttonSubmit.send_keys:return

    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    respons = wait.until { 
      el = @driver.find_elements(:css => '.modal-dialog .alert.alert-success .message') 
      if el[0].displayed?
        return el
      else
        el2 = @driver.find_elements(:css => '#editProfile span.errors') 
        if !el2.empty?
          return el2  
        end
      end
    }

    # puts element
    el = @driver.find_element(:css => '.modal-dialog .alert.alert-success .message') 

    if el.displayed?
      respons =  @driver.find_elements :css => '.modal-dialog .alert.alert-success .message'
    else  
      respons = @driver.find_elements :css => "#editProfile span.errors"
    end

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
