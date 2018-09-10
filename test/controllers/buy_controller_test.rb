require 'test_helper'

class BuyControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get buy_show_url
    assert_response :success
  end

end
