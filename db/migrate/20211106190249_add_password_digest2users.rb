class AddPasswordDigest2users < ActiveRecord::Migration[6.1]
  def change
    # Adding secure password to User table.
    # https://edgeapi.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
    add_column(:users, :password_digest, :string)
  end
end
