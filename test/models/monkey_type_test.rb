# frozen_string_literal: true

require 'test_helper'

class MonkeyTypeTest < ActiveSupport::TestCase
  # ----------------------------------------
  # For re-use in testing where applicable.
  MONKEY_SQUIRREL_SETUP_PARAMS = {
    name: 'central american squirrel monkey',
    scientific_name: 'Saimiri oerstedii',
    colloquial_name: 'Squirrel Monke',
    age: 5,
    friendliness: 10 }

  MONKEY_TAMARIN_SETUP_PARAMS = {
    name: 'emperor tamarin',
    scientific_name: 'saguinus imperator',
    colloquial_name: 'new groove',
    age: 7,
    friendliness: 9 }

  # ----------------------------------------
  # Setup is run before each test.
  def setup
    @monkey_type = MonkeyType.new(MONKEY_TAMARIN_SETUP_PARAMS)
  end

  # ----------------------------------------
  test 'monkey type should be valid' do
    assert(@monkey_type.valid?)
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
    @monkey_type_two = MonkeyType.new(name: MONKEY_TAMARIN_SETUP_PARAMS[:name])
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
