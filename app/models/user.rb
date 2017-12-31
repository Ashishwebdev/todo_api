class User < ApplicationRecord
# encrypted password
has_secure_password

# Model association
has_many :todos, foreign_key: :created_by
  #validations
validates_presence_of :name, :email, :password_digest
end
