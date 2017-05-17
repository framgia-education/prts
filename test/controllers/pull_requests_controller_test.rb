require 'test_helper'

class PullRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pull_requests_new_url
    assert_response :success
  end

end
