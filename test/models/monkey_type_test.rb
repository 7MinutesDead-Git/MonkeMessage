# frozen_string_literal: true

require 'test_helper'

class MonkeyTypeTest < ActiveSupport::TestCase
  test 'monkey type should be valid' do
    @monkey_type = MonkeyType.new(name: 'emperor tamarin')
    assert(@monkey_type.valid?)
  end
end
