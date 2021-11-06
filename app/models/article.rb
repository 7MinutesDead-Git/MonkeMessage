# The messages sent and received by users and monkes.
class Article < ApplicationRecord
  belongs_to(:user)

  # Ensures title and description are present in order for any Article to be saved.
  validates(
    :title,
    presence: true,
    length: {minimum: 6, maximum: 100}
  )
  validates(
    :description,
    presence: true,
    length: {minimum: 10, maximum: 1000}
  )
end
