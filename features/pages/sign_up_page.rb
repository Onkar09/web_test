require 'test/unit'
require 'selenium-webdriver'
require 'yaml'
require 'date'
require 'webshot'
require 'phantomjs/poltergeist'
require "slack"
require 'mail'
require 'net/http'
# require './features/env.rb'


class SignUp < BasePage

	attr_reader :endpoint


	def open_sign_up_url
		puts 'open'
		config = YAML.load_file './features/config.yml'
		require 'pry'
		binding.pry
		puts "This is page driver #{@driver}"
		@driver.get(config['signupurl'])
		sleep 5
		create_account = @driver.find_element(:css, ".c6.fs14.taR.skpv")
		create_account.click
		sleep 2
	end

	def get_random_email
		@random_email = "onkar+#{rand(0..9999999999999999999999999)}@yopmail.com"
		return @random_email
	end

	def get_otp(email)
		url = "http://www.yopmail.com/en/inbox.php?login=#{email}&p=r&d=&ctrl=&scrl=&spam=true&yf=115&yp=UZmH4AwL3BGH1AwDkZmx4ZGR&yj=PZwLlZmR1ZwDlZwD3AGZkZmN&v=2.9&r_c=&id="
		uri = URI(url)
		response = Net::HTTP.get(uri)
		result = /Limeroad Account - (?<otp>[0-9]+)/.match(response)
		# require 'pry'
		# binding.pry
		otp = result['otp']
		return otp
	end

	def sign_up
		create_account_text = @driver.find_element(:css, "#signFor").present?
		if create_account_text
			# get_random_email
			email = 'onkarnew@yopmail.com'
			@driver.find_element(:css, "input[data-ut='signnew']").send_keys(email)
			@driver.find_element(:css, "input[value='NEXT']").click
			sleep 2
			actualotp = get_otp(email)
			@driver.find_element(:css, "input[name='otp']").send_keys(actualotp)
			@driver.find_element(:css, "input[value='verify']").click
		else
			raise "Create account not opened"
		end
	end

	def verify_cart_icon
		raise "NUP OR FEED not displayed." if !@driver.find_element(:css, "#cartB").present?
	end
end