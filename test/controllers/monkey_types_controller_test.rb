require 'test_helper'

class MonkeyTypesControllerTest < ActionDispatch::IntegrationTest
  # ----------------------------------------
  setup do
    @monkey_type = MonkeyType.create(name: 'golden snub-nosed', age: 2, friendliness: 5)
  end

  # ----------------------------------------
  test 'should get index' do
    get monkey_types_url
    assert_response :success
  end

  # ----------------------------------------
  test 'should get new' do
    get new_monkey_type_url
    assert_response :success
  end

  # ----------------------------------------
  test 'should create monkey_type' do
    assert_difference('MonkeyType.count') do
      post monkey_types_url, params: { monkey_type: {  } }
    end

    assert_redirected_to monkey_type_url(MonkeyType.last)
  end

  # ----------------------------------------
  test 'should show monkey_type' do
    get monkey_type_url(@monkey_type)
    assert_response :success
  end

  # ----------------------------------------
  test 'should get edit' do
    get edit_monkey_type_url(@monkey_type)
    assert_response :success
  end

  # ----------------------------------------
  test 'should update monkey_type' do
    patch monkey_type_url(@monkey_type), params: { monkey_type: {  } }
    assert_redirected_to monkey_type_url(@monkey_type)
  end

  # ----------------------------------------
  test 'should destroy monkey_type' do
    assert_difference('MonkeyType.count', -1) do
      delete monkey_type_url(@monkey_type)
    end

    assert_redirected_to monkey_types_url
  end
end
