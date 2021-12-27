require "test_helper"

class CreateMonkeyTypeTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = create_test_admin_user
  end
  # ------------------------------------------------------------
  test "get new monkey_type form and create monkey_type" do
    sign_in_as @admin_user
    # Test for getting the form.
    get "/monkey_types/new"
    assert_response :success

    # Test for successfully creating a new monkey type.
    assert_difference 'MonkeyType.count', 1 do
      post monkey_types_path, params: { monkey_type: monkey_squirrel_setup_params }
      assert_response :redirect
    end

    # Test for redirection to new monkey page after.
    follow_redirect!
    assert_response :success
    # Monkey scientific name should show up somewhere in the html body.
    assert_match(
      monkey_squirrel_setup_params.dig(:scientific_name),
      response.body )
  end


  # ------------------------------------------------------------
  test "get new monkey_type form and reject invalid submission" do
    sign_in_as @admin_user
    # Test for getting the form.
    get "/monkey_types/new"
    assert_response :success

    # Test for successfully creating a new monkey type.
    assert_no_difference 'MonkeyType.count' do
      post monkey_types_path, params: { monkey_type: { name: "only name" } }
    end

    # Asserting match of text from _errors.html.erb shared partial.
    assert_match"Oops", response.body
    assert_select 'div.alert-warning'
  end
  # ------------------------------------------------------------
end
