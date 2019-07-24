class Assert

	def validateURL(driver, expected_url)
		result = false
		if driver.current_url.eql? expected_url
			result = true
		end
		return result
	end

end