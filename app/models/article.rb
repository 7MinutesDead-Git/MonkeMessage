# frozen_string_literal: true

# The message sent and received by users and Monkes.
# Belongs to user. Validates title, description and sanitizes input.
class Article < ApplicationRecord
  belongs_to(:user)

  monke_censor = 'oo OO AAH'

  validates(
    :title,
    presence: true,
    length: { minimum: 6, maximum: 100 },
    obscenity: { sanitize: true, replacement: monke_censor }
  )
  validates(
    :description,
    presence: true,
    length: { minimum: 10, maximum: 1000 },
    obscenity: { sanitize: true, replacement: monke_censor }
  )
end
