require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # The main purpose of our test is to verify that clicking the signup button
  # results in not creating a new user when the submitted information is invalid

#   By wrapping the post in the assert_no_difference method with the
# string argument 'User.count' , we arrange for a comparison between Us-
# er.count before and after the contents inside the assert_no_difference
# block. This is equivalent to recording the user count, posting the data, and
# verifying that the count is the same:

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "",
          email: "i@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end
    # we include a call to assert_template to check that a failed submission
    # re-renders the new action
    assert_template 'users/new'
  end
end
