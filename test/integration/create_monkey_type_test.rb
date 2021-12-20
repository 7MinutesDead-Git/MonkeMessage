require "test_helper"

class CreateMonkeyTypeTest < ActionDispatch::IntegrationTest
  # ------------------------------------------------------------
  test "get new monkey_type form and create monkey_type" do
    # Test for getting the form.
    get "/monkey_types/new"
    assert_response :success

    # Test for successfully creating a new monkey type.
    assert_difference 'MonkeyType.count', 1 do
      post(monkey_types_path, params: MonkeyTypeTest::SQUIRREL_TYPE_PARAMS )
      assert_response :redirect
    end

    # Test for redirection to new monkey page after.
    follow_redirect!
    assert_response :success
    # Monkey name should show up somewhere in the html body.
    assert_match "central american squirrel", response.body
  end
end