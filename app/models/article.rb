# The message sent and received by users and Monkes.
# Belongs to user. Validates title, description and sanitizes input.
class Article < ApplicationRecord
  belongs_to(:user)

  # Monke-safe censoring of excited messages.
  monke_alternatives = ['oo OO AHH', 'AH AHH', 'oh OoO OO', 'AAHH OO AHH']

  validates(
    :title,
    presence: true,
    length: {minimum: 6, maximum: 100},
    obscenity: { sanitize: true, replacement: monke_alternatives.sample}
  )
  validates(
    :description,
    presence: true,
    length: {minimum: 10, maximum: 1000},
    obscenity: { sanitize: true, replacement: monke_alternatives.sample}
  )
end
