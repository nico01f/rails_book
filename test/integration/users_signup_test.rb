require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	test "invalid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post_via_redirect users_path, user: {name: "Example", email: "user@invalid.com", password: "foo", password_confirmation: "bar", mobile_num: "5691234567"}
		end
		assert_template 'users/show'
		assert is_logged_in?
	end
end
