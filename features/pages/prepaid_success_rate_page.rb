require 'test/unit'
require 'selenium-webdriver'
require 'yaml'
require 'date'
require 'webshot'
require 'phantomjs/poltergeist'
require "slack"
require 'mail'


class PrepaidRate

	attr_reader :endpoint

	def enter_login_details
		config = YAML.load_file './features/config.yml'
		$driver.get(config['landingpageURL'])
		$driver.find_element(:id, "UserName").send_keys(config['username'])
		$driver.find_element(:id, "Alias").send_keys(config['alias'])
		$driver.find_element(:id, "Password").send_keys(config['password'])
	end

	def submit
		$driver.find_element(:css, "button[type='submit']").click
		sleep 10
	end

	def dashboard_displayed?
		dashboard_header = $driver.find_element(:id, "ButtonHeader")
		if dashboard_header.displayed?
			puts 'Dashboard displayed'
		else
			raise "Dashboard not displayed."
		end
	end

	def get_previous_date_dashboard
    	@start_date = Date.today.prev_day.strftime("%Y-%m-%d")
    	@end_date = Date.today.prev_day.strftime("%Y-%m-%d")
    	$driver.get("https://info.payu.in/merchant/overview?from=#{@start_date}&to=#{@end_date}")
	end

	def check_success_rate
		@rate = $driver.find_element(:css, "div.success_rate").text
		@rate = @rate.to_f
		puts @rate
		if @rate < 70.00
			dashboard_overview_screenshot
		end
	end

	def dashboard_overview_screenshot
		$driver.get("https://info.payu.in/merchant/overview?from=#{@start_date}&to=#{@end_date}")
		$driver.save_screenshot('/Users/onkar/Documents/cucumber_project/features/screenshots/dashboard.png')
		@screenshot_url = '/Users/onkar/Documents/cucumber_project/features/screenshots/dashboard.png'
		# slack_upload(@screenshot_url)
		send_mail(@screenshot_url, @rate)
	end

	def slack_upload(screenshot_url)
		Slack.configure do |config|
  			config.token = 'xoxb-395620120852-651551905746-vwEShc1lqnewkpsillGAoksB'
  		end
  		client = Slack::Web::Client.new
  		client.files_upload(
		  channels: '#prod_release_logs',
		  as_user: true,
		  file: Faraday::UploadIO.new(@screenshot_url, 'image/png'),
		  title: 'Prepaid Success Rate',
		  filename: 'dashboard.png',
		  initial_comment: 'Prepaid Success Rate Decreased. Attached a screenshot.'
		)
	end

	def send_mail(screenshot_url, rate)
		mail = Mail.new do
			from     "onkar@limeroad.com"
			# to       "p0-qa@lmrd.pagerduty.com" # for Pager Duty alert
			to       "onkar@limeroad.com"
			subject  "P0 Prepaid Success Rate is Down. Yesterday Success Rate was #{rate}"
			body     "Prepaid Success Rate is Down. Yesterday Success Rate was #{rate}"
		end
		mail.add_file(screenshot_url)
		mail.delivery_method :sendmail

		mail.deliver
	end
end