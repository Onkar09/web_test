# require 'rubygems'
# require 'rspec'
# require "selenium-webdriver"
# require 'rspec/expectations'
# require 'yaml'
# require 'test/unit'
# require 'spec_helper'
# include RSpec::Matchers
# require 'require_all'
# require '/Users/onkar/Documents/cucumber_project/features/support/base'

# require_all '/Users/onkar/Documents/cucumber_project/features/support/*.rb'

# class BasePage < Test::Unit::TestCase
class BasePage

	attr_accessor :browser

	def initialize(browser)	
		@driver = browser
	end

end


# 	def initialize
# 		set_driver_path

# 		Before do |scenario|
# 			p "Starting #{scenario}"
# 		  	if environment == :staging
# 		    	@browser = Selenium::WebDriver.new(:remote, :url=>"http://localhost:4444/wd/hub", :desired_capabilities=> browser_name)
# 		    	@browser.goto "https://sdet.us/selenium-grid-up-and-running-with-cucumber-automation/"
# 		  	elsif environment == :local
# 		    	@browser = Selenium::WebDriver.new browser_name
# 				@browser.goto "http://integration.env.com:8080"
# 			end
# 		end

#     	After do |scenario|
# 			teardown
# 		end		
# 	end

# 	def set_driver_path
# 		Selenium::WebDriver::Chrome::Service::driver_path='./features/Drivers/chromedriver'
# 	end
# 	# Selenium::WebDriver::Chrome.driver_path='./features/Drivers/chromedriver'
# 		# Selenium::WebDriver::Chrome::Service::driver_path='./features/Drivers/chromedriver'
# 	# 	# chrome_options = Selenium::WebDriver::Chrome::Options.new
# 	# 	# # options.add_argument('--headless')
# 	# 	# # chrome_options = Options()
# 	# 	# chrome_options.add_argument('--headless')
# 	# 	# chrome_options.add_argument('--no-sandbox')
# 	# 	# chrome_options.add_argument('--disable-dev-shm-usage')
# 	# 	# @driver = Selenium::WebDriver.for :chrome, options: chrome_options
# 	# 	# @driver.manage.timeouts.implicit_wait = 120 # seconds
# 	# 	# @driver = Selenium::WebDriver::for :chrome
# 	# 	# @driver = Selenium::WebDriver::for :firefox
# 	# 	# @driver.manage.window.resize_to(1440,900)
# 	# 	# @driver.manage.window.resize_to(411,823)
# 	# 	# @driver.manage.window.maximize


# 	def teardown
# 		@browser.quit
# 	end


# 	def browser_name
# 		(ENV[‘BROWSER’] ||= ‘firefox’).downcase.to_sym
# 	end

# 	def environment
# 		(ENV[‘ENVI’] ||= ‘int’).downcase.to_sym
# 	end

# end
