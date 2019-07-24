When("I do new relic login") do
  puts "I am on new relic login page"
  @newrelic = NewRelic.new
  @newrelic.new_relic_login
end
 
And("I open new relic errors") do
	@newrelic.select_time_period_60_mins
end

Then("I check the errors") do
	@newrelic.check_error_rate
end