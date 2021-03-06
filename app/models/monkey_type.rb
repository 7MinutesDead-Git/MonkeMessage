# The type of monkey a Monke can be. Includes age and friendliness.
class MonkeyType < ApplicationRecord
  AGE_MIN = 0
  AGE_MAX = 10000
  NAME_MIN_LENGTH = 3
  NAME_MAX_LENGTH = 50
  FRIENDLY_MIN = 0
  FRIENDLY_MAX = 10

  validates(
    :name,
    presence: true,
    length: { minimum: NAME_MIN_LENGTH, maximum: NAME_MAX_LENGTH } )

  validates(
    :scientific_name,
    presence: true,
    length: { minimum: NAME_MIN_LENGTH, maximum: NAME_MAX_LENGTH } )

  validates(
    :colloquial_name,
    presence: true,
    length: { minimum: NAME_MIN_LENGTH, maximum: NAME_MAX_LENGTH } )

  validates(
    :age,
    numericality: true,
    inclusion: { in: AGE_MIN..AGE_MAX } )

  validates(
    :friendliness,
    inclusion: { in: FRIENDLY_MIN..FRIENDLY_MAX } )

  validates_uniqueness_of :name
end
