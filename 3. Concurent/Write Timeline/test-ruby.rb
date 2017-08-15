require "selenium-webdriver"

class Test
  def initialize(testCase,driver)
    @testCase =  testCase
    @driver =  driver
  end
  def run
    # Here some example
    wait = Selenium::WebDriver::Wait.new(:timeout => 30)

    element = @driver.find_element(:css => '.timeline .card.new')
    # @driver.execute_script("arguments[0].click()" , element)
    element.click

    wait.until { @driver.find_element(:css => '#newTimeline .modal-dialog').displayed? }

    inputs = @testCase['testCases']

    inputs.each do |key,input|
      element = @driver.find_element :css => "#newTimeline #{key}"
      if(key === "[name='categories']")
        @driver.execute_script("arguments[0].value='#{input}'" , element)
      else
        # for i in 0..input.length-1
        #   element.send_keys input[i]
        # end
        @driver.execute_script("arguments[0].value='#{input}'" , element)
        @driver.execute_script("arguments[0].innerHTML='#{input}'" , element)
      end
    end

    buttonSubmit = @driver.find_element :css => "#newTimeline .modal-footer .btn-primary"
    buttonSubmit.click
    # @driver.execute_script("arguments[0].click()" , buttonSubmit)
    # #
    wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    # wait.until { @driver.find_element(:css => " #timeline-list .alert.alert-danger .message, #timeline-list .timeline-item-container .new-item:first-child .timeline-content").displayed? }
    wait.until { @driver.find_element(:css => "#newTimeline .sharing-errors span.errors, .timeline-item-container .new-item:first-child .timeline-content").displayed? }

    respons = @driver.find_elements :css => "#newTimeline .sharing-errors span.errors, .timeline-item-container .new-item:first-child .timeline-content"

    # puts respons

    result = Array.new

    respons.each do |respon|
      result.push respon.text
    end

    expect = @testCase['messages']
    puts expect
    puts "////"
    puts result
    puts Set.new(expect) === Set.new(result)
    return Set.new(expect) === Set.new(result)
  end
end
