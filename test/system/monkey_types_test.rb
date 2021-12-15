require "application_system_test_case"

class MonkeyTypesTest < ApplicationSystemTestCase
  setup do
    @monkey_type = monkey_types(:one)
  end

  test "visiting the index" do
    visit monkey_types_url
    assert_selector "h1", text: "Monkey Types"
  end

  test "creating a Monkey type" do
    visit monkey_types_url
    click_on "New Monkey Type"

    click_on "Create Monkey type"

    assert_text "Monkey type was successfully created"
    click_on "Back"
  end

  test "updating a Monkey type" do
    visit monkey_types_url
    click_on "Edit", match: :first

    click_on "Update Monkey type"

    assert_text "Monkey type was successfully updated"
    click_on "Back"
  end

  test "destroying a Monkey type" do
    visit monkey_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Monkey type was successfully destroyed"
  end
end
