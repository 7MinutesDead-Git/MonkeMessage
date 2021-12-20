require "test_helper"

class CreateMonkeyTypeTest < ActionDispatch::IntegrationTest
  # ------------------------------------------------------------
  test "get new monkey_type form and create monkey_type" do
    # Test for getting the form.
    get "/monkey_types/new"
    assert_response :success

    # Test for successfully creating a new monkey type.
    assert_difference 'MonkeyType.count', 1 do
      post monkey_types_path, params: { monkey_type: MonkeyTypeTest::MONKEY_SQUIRREL_SETUP_PARAMS }
      assert_response :redirect
    end

    # Test for redirection to new monkey page after.
    follow_redirect!
    assert_response :success
    # Monkey scientific name should show up somewhere in the html body.
    assert_match(
      MonkeyTypeTest::MONKEY_SQUIRREL_SETUP_PARAMS.dig(:scientific_name),
      response.body )
  end
  # ------------------------------------------------------------
end
