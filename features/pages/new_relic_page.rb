require 'test/unit'
require 'selenium-webdriver'
require 'yaml'
require 'date'
require 'webshot'
require 'phantomjs/poltergeist'
require "slack"
require 'mail'
require 'net/http'


class NewRelic

	attr_reader :endpoint

	def new_relic_login
		config = YAML.load_file './features/config.yml'
		$driver.get(config['newrelicloginurl'])
		$driver.find_element(:id, "login_email").send_keys(config['new_relic_username'])
		$driver.find_element(:id, "login_password").send_keys(config['new_relic_password'])
		$driver.find_element(:id, "login_submit").click
		$driver.get(config['new_relic_error_url'])
	end

	def select_time_period_60_mins
		$driver.find_element(:id, 'time_window_nav').click
		$driver.find_element(:css, "a[data-open-duration='last_60_minutes']").click
		sleep 5
	end

	def check_error_rate
		@error_rates = $driver.find_elements(:css, "g.highcharts-axis-labels text[x='0']")
		@error_rates.each do |rate|
			if rate.text.to_f == 0.05
				get_errors
			end
		end
	end

	def get_errors
		@all_errors = $driver.find_elements(:css, "#errors tbody tr")
		@error = @all_errors.first
		@error = @error.text.split("\n")
		# @error = @error.split("\n")
		@count = @error[3].split(//).map {|x| x[/\d+/]}.compact.join("").to_i
		@actual_error = "Error is ===>>> #{@error[1]}, #{@error[2]}, #{@error[3]}"
		puts @actual_error
		send_mail_without_screenshot(@actual_error)
	end

	def new_relic_errors_screenshot
		$driver.save_screenshot('./features/screenshots/new_relic_error.png')
		@screenshot_url = './features/screenshots/new_relic_error.png'
		# slack_upload(@screenshot_url)
		send_mail(@screenshot_url, @actual_error)
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
		  title: 'New Relic Error Rate',
		  filename: 'dashboard.png',
		  initial_comment: 'Prepaid Success Rate Decreased. Attached a screenshot.'
		)
	end

	def send_mail(screenshot_url, error)
		mail = Mail.new do
			from     "onkar@limeroad.com"
			# to       "p0-qa@lmrd.pagerduty.com" # for Pager Duty alert
			to       "onkar@limeroad.com"
			subject  "P0 #{error}"
			body     "#{error}"
		end
		mail.add_file(screenshot_url)
		mail.delivery_method :sendmail

		mail.deliver
	end

	def send_mail_without_screenshot(error)
		mail = Mail.new do
			from     "onkar@limeroad.com"
			# to       "p0-qa@lmrd.pagerduty.com" # for Pager Duty alert
			to       "onkar@limeroad.com"
			subject  "P0 #{error}"
			body     "#{error}"
		end
		mail.delivery_method :sendmail

		mail.deliver
	end


end