require 'rubygems'
require 'rspec'
require "selenium-webdriver"
require 'rspec/expectations'
require 'yaml'
require 'test/unit'
require 'thread'
# require 'spec_helper'
# include RSpec::Matchers
# require 'require_all'
# require '/Users/onkar/Documents/cucumber_project/features/support/base'

# require_all '/Users/onkar/Documents/cucumber_project/features/support/*.rb'
def set_capabilities
	hub_url = "http://localhost:4444/wd/hub"
  	capabilities = Selenium::WebDriver::Remote::Capabilities.new
  	capabilities = capabilities
   	capabilities['url'] = hub_url	
   	capabilities['platformName'] = 'MAC'
   	capabilities['browserName'] = set_browser
   	puts capabilities['browserName']
	capabilities
end

def set_browser
	case ENV['BROWSER']
	when "chrome"
		browser = "chrome"
	when "firefox"
		browser = "firefox"
	when "safari"
		browser = "safari"
	else
		browser = "chrome"
	end
	browser
end

def launch_chrome
	# set_driver_path
	puts 'chrome'
	# hub_url = "http://localhost:4444/wd/hub"
  	@capabilities1 = Selenium::WebDriver::Remote::Capabilities.new
   	# @capabilities1['url'] = hub_url	
   	@capabilities1['platformName'] = 'MAC'
   	@capabilities1['browserName'] = "chrome"
   	@capabilities1
   	@driver1 = Selenium::WebDriver.for :remote, :desired_capabilities => @capabilities1, :url=>"http://localhost:4444/wd/hub"
   	puts "Chrome Driver #{@driver}"
   	@driver1
end

def launch_firefox
	puts "fire"
	# hub_url = "http://localhost:4444/wd/hub"
  	@capabilities2 = Selenium::WebDriver::Remote::Capabilities.new
   	# @capabilities2['url'] = hub_url	
   	@capabilities2['platformName'] = 'MAC'
   	@capabilities2['browserName'] = "firefox"
   	@capabilities2
   	@driver2 = Selenium::WebDriver.for :remote, :desired_capabilities => @capabilities2, :url=>"http://localhost:4444/wd/hub"
   	puts  "firefox Driver #{@driver}"
   	@driver2
end

def launch_safari
	# hub_url = "http://localhost:4444/wd/hub"
  	@capabilities3 = Selenium::WebDriver::Remote::Capabilities.new
   	# @capabilities3['url'] = hub_url	
   	@capabilities3['platformName'] = 'MAC'
   	@capabilities3['browserName'] = "safari"
   	@capabilities3
   	@driver3 = Selenium::WebDriver.for :remote, :desired_capabilities => @capabilities3, :url=>"http://localhost:4444/wd/hub"
   	@driver3
end

def multi_launch
	puts 'multi'
	t1 = Thread.new{launch_chrome}
	puts "Thread 1 #{t1}"
	t2 = Thread.new{launch_firefox}
	puts "Thread 2 #{t2}"
	t3 = Thread.new{launch_safari}
	t1.join
	t2.join
	t3.join
end

def set_driver_path
	Selenium::WebDriver::Chrome::Service::driver_path='./features/Drivers/chromedriver'
end


def teardown
	@driver.quit
end


def browser_name
	(ENV[‘BROWSER’] ||= ‘firefox’).downcase.to_sym
end

def environment
	(ENV[‘ENVI’] ||= ‘int’).downcase.to_sym
end


# Before do |scenario|
# 		# set_driver_path
# 		# p "Starting #{scenario}"
# 	  	# if environment == :staging
# 	  	# hub_url = "http://localhost:4444/wd/hub"
# 	  	# capabilities = Selenium::WebDriver::Remote::capabilities.new
#     #    	capabilities['url'] = hub_url	
#     #    	capabilities['platformName'] = 'MAC'
#     #    	capabilities['browserName'] = set_browser
#     # #    	puts capabilities['browserName']
#     # 	set_capabilities
#     # 	# @browser = Selenium::WebDriver.new(:remote, :url=>"http://localhost:4444/wd/hub", :desired_capabilities=> 'chrome')
#     # 	@driver = Selenium::WebDriver.for :remote, :desired_capabilities => capabilities, :url=>"http://localhost:4444/wd/hub"
#     # 	puts "This is env #{@driver}"
#  #    puts 'before'
# 	# @launch = Env.new
# 	# @launch.multi_launch
# end

# After do |scenario|
# 	# @launch.teardown
# end		