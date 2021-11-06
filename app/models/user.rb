# Users who can login, send and receive messages, etc.
class User < ApplicationRecord
  # Each user can create many articles/messages.
  has_many(:articles)

  # Validation: Present, unique, valid length.
  validates(:username,
            presence: true,
            # Uniqueness defaults to true, but we can also specify false for case-sensitivity only.
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 })

  validates(:email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            # Verify email with ruby's standard library regex.
            format: { with: URI::MailTo::EMAIL_REGEXP })

  # Ensure all emails are saved as lowercase for simplicity and consistency.
  # Note that before_save is only called after validation has passed.
  before_save { self.email = email.downcase }

end

