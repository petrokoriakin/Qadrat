require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  test "should get follow_tag" do
    get :follow_tag
    assert_response :success
  end

  test "should get unfollow_tag" do
    get :unfollow_tag
    assert_response :success
  end

end
