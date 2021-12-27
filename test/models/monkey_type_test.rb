# frozen_string_literal: true

require 'test_helper'

class MonkeyTypeTest < ActiveSupport::TestCase
  # ----------------------------------------
  # Setup is run before each test.
  def setup
    @monkey_type = MonkeyType.new(monkey_tamarin_setup_params)
  end

  # ----------------------------------------
  test 'monkey type should be valid' do
    assert @monkey_type.valid?
  end

  # ----------------------------------------
  test 'monkey type name should be present' do
    @monkey_type.name = '    '
    assert_not @monkey_type.valid?
  end

  # ----------------------------------------
  test 'monkey type friendliness should not exceed maximum' do
    @monkey_type.friendliness = MonkeyType::AGE_MAX + 1
    assert_not @monkey_type.valid?
  end

  # ----------------------------------------
  test 'monkey type friendliness should not be below zero' do
    @monkey_type.friendliness = MonkeyType::FRIENDLY_MIN - 1
    assert_not @monkey_type.valid?
  end

  # ----------------------------------------
  test 'monkey type name should be unique' do
    @monkey_type.save
    @monkey_type_two = MonkeyType.new(name: monkey_tamarin_setup_params[:name])
    assert_not @monkey_type_two.valid?
  end

  # ----------------------------------------
  test 'monkey type name should be not be excessively long' do
    @monkey_type.name = 'm' * (MonkeyType::NAME_MAX_LENGTH + 1)
    assert_not @monkey_type.valid?
  end

  # ----------------------------------------
  test 'monkey type name should be not be excessively short' do
    @monkey_type.name = MonkeyType::NAME_MIN_LENGTH - 1
    assert_not @monkey_type.valid?
  end
end
