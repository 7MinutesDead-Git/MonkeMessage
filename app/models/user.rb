class User < ApplicationRecord
  has_many(:articles)

  # Verify entry with .valid?.
  # After .valid? check (or .save attempt), if false, then .errors.full_messages can be checked.

  # Validation: Present, unique, valid length.
  # Uniqueness defaults to true, but we can specify false for case sensitivity specifically.
  validates(:username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 })

  validates(:email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            # Verify email with ruby's standard library regex.
            format: { with: URI::MailTo::EMAIL_REGEXP })

end

