When("I do login") do
  puts "I am on PayU login page"
  @prepaid = PrepaidRate.new
  @prepaid.enter_login_details
  @prepaid.submit
end

And("I see overview page") do 
	@prepaid.dashboard_displayed?
end

And("I open dashboard for previous day") do
	@prepaid.get_previous_date_dashboard
end

Then("I check the success rate for yesterday") do
	@prepaid.check_success_rate
end
