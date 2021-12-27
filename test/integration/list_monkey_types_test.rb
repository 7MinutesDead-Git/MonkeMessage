require "test_helper"

class ListMonkeyTypesTest < ActionDispatch::IntegrationTest
  # ----------------------------------------
  setup do
    @squirrel_monkey = MonkeyType.create(MonkeyTypeTest::MONKEY_SQUIRREL_SETUP_PARAMS)
    @tamarin_monkey = MonkeyType.create(MonkeyTypeTest::MONKEY_TAMARIN_SETUP_PARAMS)
  end

  # ----------------------------------------
  test "Should show monkey types listing" do
    get '/monkey_types'
    assert_select "a[href=?]", monkey_type_path(@squirrel_monkey), text: @squirrel_monkey.name
    assert_select "a[href=?]", monkey_type_path(@tamarin_monkey), text: @tamarin_monkey.name
  end

  # ----------------------------------------
end
