require 'test_helper'

class MonkeyTypesControllerTest < ActionDispatch::IntegrationTest
  # ----------------------------------------
  setup do
    @monkey_type = MonkeyType.create(monkey_golden_setup_params)
    @admin_user = create_test_admin_user
  end

  # ----------------------------------------
  test 'should get index' do
    get monkey_types_url
    assert_response :success
  end

  # ----------------------------------------
  test 'should get new' do
    sign_in_as(@admin_user)
    get new_monkey_type_url
    assert_response :success
  end

  # ----------------------------------------
  test 'should create monkey_type' do
    sign_in_as(@admin_user)
    assert_difference('MonkeyType.count', 1) do
      post(monkey_types_url,
           params: { monkey_type: monkey_squirrel_setup_params } )
    end
    assert_redirected_to monkey_type_url(MonkeyType.last)
  end

  # ----------------------------------------
  test 'should show monkey_type' do
    get monkey_type_url(@monkey_type)
    assert_response :success
  end

  # ----------------------------------------
  test 'should not create monkey type if not admin' do
    assert_no_difference('MonkeyType.count') do
      post(monkey_types_url,
           params: { monkey_type: monkey_squirrel_setup_params } )
    end
    assert_redirected_to monkey_types_url
  end

  # # ----------------------------------------
  # test 'should get edit' do
  #   get edit_monkey_type_url(@monkey_type)
  #   assert_response :success
  # end
  #
  # # ----------------------------------------
  # test 'should update monkey_type' do
  #   patch monkey_type_url(@monkey_type), params: { monkey_type: {  } }
  #   assert_redirected_to monkey_type_url(@monkey_type)
  # end
  #
  # # ----------------------------------------
  # test 'should destroy monkey_type' do
  #   assert_difference('MonkeyType.count', -1) do
  #     delete monkey_type_url(@monkey_type)
  #   end
  #   assert_redirected_to monkey_types_url
  # end
end
