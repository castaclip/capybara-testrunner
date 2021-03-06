require "selenium/client"
require "json"

class SeleniumRCRunner
  def initialize(app_host, selenium_host, browser_string)
    @browser = Selenium::Client::Driver.new(
             :host => selenium_host,
             :port => 4444, 
             :browser => browser_string,
             :url => app_host, 
             :timeout_in_seconds => 300)

    puts "#{Time.now.to_s} - Starting selenium browser session..."
    @browser.start_new_browser_session    
    puts "#{Time.now.to_s} - Browser session started"
    puts @browser.js_eval("navigator.userAgent")
    
  end
  
  def open(url)
     @browser.open(url)
  end
  
  def js_eval(javascript)
    # it seems sometimes the window.JSON object doesn't exist, hopefully this is a timing issue and
    # it will eventually exist
    results_str = @browser.js_eval("if(window.JSON) window.JSON.stringify(window.#{javascript})")
    JSON.parse(results_str)
  end
  
  def save_screenshot(file_path)
    @browser.capture_screenshot(File.join(Dir.pwd, file_path))
  end
  
  def body
    @browser.get_html_source
  end
  
  def close()
    @browser.close_current_browser_session
  end
end