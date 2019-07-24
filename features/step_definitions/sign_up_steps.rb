When("I am on sign up page") do
	@signup = SignUp.new
	# @signup.multi_launch
	@signup.open_sign_up_url
end

Then("I enter email address") do
	@signup.sign_up
	@signup.verify_cart_icon
	# @signup.teardown
end

# Then("I should able to login") do

# end