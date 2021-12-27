ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # -----------------------------
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors, with: :threads)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Additional helper methods.
  # -----------------------------
  def sign_in_as(user)
    post login_path, params: { session: { email: user.email, password: "password" } }
  end

  def create_test_admin_user
    User.create(
      username: "TestAdmin",
      email: "TestAdmin@Admin",
      password: "password",
      admin: true )
  end

  # -----------------------------
  def monkey_squirrel_setup_params
    { name: 'central american squirrel monkey',
      scientific_name: 'Saimiri oerstedii',
      colloquial_name: 'Squirrel Monke',
      age: 5,
      friendliness: 10 }
  end

  def monkey_tamarin_setup_params
    { name: 'emperor tamarin',
      scientific_name: 'saguinus imperator',
      colloquial_name: 'new groove',
      age: 7,
      friendliness: 9 }
  end

  def monkey_golden_setup_params
    { name: 'golden snub-nosed',
      scientific_name: 'Rhinopithecus roxellana',
      colloquial_name: 'golden boi',
      age: 2,
      friendliness: 5 }
  end
end
