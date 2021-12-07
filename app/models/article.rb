# The message sent and received by users and Monkes.
# Belongs to user. Validates title, description and sanitizes input.
class Article < ApplicationRecord
  belongs_to(:user)

  validates(
    :title,
    presence: true,
    length: {minimum: 6, maximum: 100},
    obscenity: true
  )
  validates(
    :description,
    presence: true,
    length: {minimum: 10, maximum: 1000},
    obscenity: true
  )
end
